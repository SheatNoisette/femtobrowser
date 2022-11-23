/*
** From a AST, make a 2d representation of the page for easy rendering
** It's not a real 2d representation, but a 1d representation of the
** 2d page. It is not the best way to do it, but it's the easiest.
*/

struct FemtoLinearPage {
mut:
	tag     FemtoTag
	content string
}

fn linearize_ast(ast FemtoPageAST) []FemtoLinearPage {
	mut res := []FemtoLinearPage{}
	linearize_ast_rec(ast, mut res)
	return res
}

fn linearize_ast_rec(ast FemtoPageAST, mut res []FemtoLinearPage) {
	for children in ast.children {
		log_debug('Linearize: Adding ${children.tag}')
		res << FemtoLinearPage{
			tag: children.tag
			content: children.content
		}
		linearize_ast_rec(children, mut res)
	}
}
