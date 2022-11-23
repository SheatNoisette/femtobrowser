module main

/*
** Tag definition and conversion
*/

const (
	tag_str_dict = {
		'html':       FemtoTag.html
		'body':       FemtoTag.body
		'head':       FemtoTag.head
		'p':          FemtoTag.p
		'h1':         FemtoTag.h1
		'h2':         FemtoTag.h2
		'h3':         FemtoTag.h3
		'h4':         FemtoTag.h4
		'h5':         FemtoTag.h5
		'h6':         FemtoTag.h6
		'center':     FemtoTag.center
		'div':        FemtoTag.div
		'dd':         FemtoTag.dd
		'dt':         FemtoTag.dt
		'code':       FemtoTag.code
		'ul':         FemtoTag.ul
		'li':         FemtoTag.li
		'blockquote': FemtoTag.blockquote
		'script':     FemtoTag.script
		'meta':       FemtoTag.meta
		'a':          FemtoTag.address
		'link':       FemtoTag.link
		'style':      FemtoTag.style
		'title':      FemtoTag.title
		'source':     FemtoTag.source
		'pre':        FemtoTag.pre
		'audio':      FemtoTag.audio
	}
)

// Enum of important HTML tag
enum FemtoTag {
	html
	body
	head
	p
	h1
	h2
	h3
	h4
	h5
	h6
	center
	div
	a
	dd
	dt
	code
	ul
	li
	blockquote
	script
	meta
	link
	address
	style
	title
	source
	pre
	audio
	unknown
}

// Convert a string representation of HTML tag to enum
fn str_to_tag(input string) FemtoTag {
	if input.to_lower() in tag_str_dict {
		return tag_str_dict[input.to_lower()]
	}
	return FemtoTag.unknown
}

// Check if a tag is a heading tag
fn is_heading_tag(tag FemtoTag) bool {
	temp_dict := {
		FemtoTag.h1: true
		FemtoTag.h2: true
		FemtoTag.h3: true
		FemtoTag.h4: true
		FemtoTag.h5: true
		FemtoTag.h6: true
	}
	return tag in temp_dict
}
