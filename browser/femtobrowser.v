module main

import os
import net.html

fn main() {
	// Get the page from arguments
	if os.args.len < 2 {
		log_error('No URL provided')
		return
	}

	// Get the page
	page := request_page(os.args[1]) or {
		log_error("Couldn't get the page")
		return
	}

	log_debug('Parsing page...')
	parsed_page := parse_page(html.parse(page.raw_html).get_root())
	log_debug('Done parsing page, linearizing...')
	linear_page := linearize_ast(parsed_page)
	log_debug('Done linearizing page')
	render_page_ui(linear_page)
}
