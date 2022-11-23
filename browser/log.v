module main

import time

/*
** Yeah, there is a "log" module inside Vlib, but you need to make a struct
** that need to be passed around.
*/

// Logging level
enum LoggingLevel {
	error
	warning
	debug
}

// Logging level to string
fn logging_to_string(loglevel LoggingLevel) string {
	return match loglevel {
		.error { 'ERROR' }
		.warning { 'WARNING' }
		.debug { 'DEBUG' }
	}
}

fn logger_format(level LoggingLevel, message string) {
	timestamp := time.now().format_ss()
	logging_string := logging_to_string(level)
	final_string := '${timestamp} [${logging_string}] ${message}'

	if level == LoggingLevel.error {
		eprintln(final_string)
	} else {
		println(final_string)
	}
}

// Log a warning
[inline]
pub fn log_warn(message string) {
	logger_format(.warning, message)
}

// Log a error
[inline]
pub fn log_error(message string) {
	logger_format(.error, message)
}

// Logging a debug message
[inline]
pub fn log_debug(message string) {
	logger_format(.debug, message)
}
