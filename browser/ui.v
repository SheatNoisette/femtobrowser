module main

import gg
import gx

/*
** Simple frontend to V gg
*/

const (
	// Tags that are accepted by wrapper
	ignored_tags = {
		FemtoTag.address: true
		FemtoTag.h1:      true
		FemtoTag.h2:      true
		FemtoTag.h3:      true
		FemtoTag.h4:      true
		FemtoTag.h5:      true
		FemtoTag.h6:      true
		FemtoTag.p:       true
		FemtoTag.pre:     true
		FemtoTag.unknown: true
		FemtoTag.code:    true
	}

	// Size of the text by default
	default_size        = 15

	// Size by default based on the tag
	default_size_by_tag = {
		FemtoTag.h1: 30
		FemtoTag.h2: 25
		FemtoTag.h3: 20
		FemtoTag.h4: 15
		FemtoTag.h5: 10
		FemtoTag.h6: 5
	}
)

struct FemtobrowserUIContext {
	pages []FemtoLinearPage
mut:
	ggcontext &gg.Context
}

fn render_page_ui(pages []FemtoLinearPage) {
	log_warn('Starting UI...')

	mut appctx := FemtobrowserUIContext{
		pages: pages
		ggcontext: 0
	}
	appctx.ggcontext = gg.new_context(
		bg_color: gx.rgb(255, 255, 255)
		width: 800
		height: 600
		window_title: 'Femtobrowser'
		frame_fn: frame
		user_data: &appctx
	)
	appctx.ggcontext.run()
	log_warn('UI stopped')
}

fn get_gxtextcfg_tag(tag FemtoTag) gx.TextCfg {
	// Override default size based on the tag
	if is_heading_tag(tag) {
		return gx.TextCfg{
			color: gx.black
			align: .left
			vertical_align: .middle
			size: default_size_by_tag[tag]
		}
	}

	return gx.TextCfg{
		color: gx.black
		align: .left
		vertical_align: .middle
		size: default_size
	}
}

fn frame(mut appctx FemtobrowserUIContext) {
	mut y := 0

	appctx.ggcontext.begin()

	for page in appctx.pages {
		// If we don't want to render some tags, skip them
		if page.tag !in ignored_tags {
			continue
		}

		// We have a tag to render, fetch the default config for it
		mut textcfg := get_gxtextcfg_tag(page.tag)

		// Force increment to avoid the text being cutted
		if y == 0 {
			y += textcfg.size
		}

		// Render the text
		appctx.ggcontext.draw_text(5, y, page.content, textcfg)

		// Increment the y position
		y += textcfg.size
	}

	appctx.ggcontext.end()
}
