module main

/*
** Use V HTML parser to build a simple AST
*/
import net.http
import net.html

enum FemtoPageState {
	requested
	error
	empty
}

struct FemtoPage {
mut:
	page_stage FemtoPageState = .empty
	url        string
	raw_html   string
	title      string
}

struct FemtoPageAST {
mut:
	is_root    bool
	tag        FemtoTag
	tag_str    string
	content    string
	attributes map[string]string
	children   []FemtoPageAST
}

// Get the page
// TODO: Timeout
fn request_page(url string) ?FemtoPage {
	// Get the page
	mut new_page := FemtoPage{}

	// Request the page
	log_debug("Requesting '${url}'")

	// Do a request
	request := http.get(url) or {
		log_error("Couldn't request the page '${url}'")
		new_page.page_stage = .error
		return new_page
	}

	// Check success
	if request.status() != .ok {
		log_error("Unexpected status for request to '${url}' - Got '${request.status()}'")
		new_page.page_stage = .error
		return new_page
	} else {
		log_debug("Successfully requested '${url}'")
	}

	// Fill the struct
	new_page.raw_html = http.get_text(url)
	new_page.url = url
	new_page.page_stage = .requested

	return new_page
}

// Convert from a http parse to a FemtoPage
fn parse_page(tag &html.Tag) FemtoPageAST {
	mut new_page := FemtoPageAST{
		is_root: true
	}
	new_page.children << parsed_page_recursive(tag, mut new_page)
	return new_page
}

fn parsed_page_recursive(tag &html.Tag, mut root FemtoPageAST) FemtoPageAST {
	mut ast := FemtoPageAST{}
	ast.tag = str_to_tag(tag.name)
	ast.tag_str = tag.name
	ast.content = tag.content.trim_space()
	ast.attributes = tag.attributes.clone()
	ast.children = []FemtoPageAST{}

	for child in tag.children {
		ast.children << parsed_page_recursive(child, mut root)
	}

	return ast
}
