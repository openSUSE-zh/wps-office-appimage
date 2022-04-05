import ui
import os

const (
	win_width  = 512
	win_height = 512
)

struct App {
mut:
	window &ui.Window = 0
}

fn main() {
  mut wps := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-wpsmain.png")
  mut et := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-etmain.png")
  mut wpp := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-wppmain.png")
  mut pdf := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-pdfmain.png")

	mut app := &App{}

	app.window = ui.window(
		width: win_width
		height: win_height
		title: 'WPS Office Launcher'
		state: app
		mode: .resizable
		children: [
			ui.row(
				children: [
          ui.column(
            children: [
					    ui.picture(width: 256, height: 256, path: wps, on_click: wps_click),
              ui.picture(width: 256, height: 256, path: et, on_click: et_click)
            ]
          ),
          ui.column(
            children: [
              ui.picture(width: 256, height: 256, path: wpp, on_click: wpp_click),
              ui.picture(width: 256, height: 256, path: pdf, on_click: pdf_click)
            ]
          ),
        ]
      ),
		]
	)
	ui.run(app.window)
}

fn wps_click(a voidptr, b voidptr) {
  os.execute(os.resource_abs_path("opt/kingsoft/wps-office/office6/wps"))
  exit(0)
}

fn et_click(a voidptr, b voidptr) {
  os.execute(os.resource_abs_path("opt/kingsoft/wps-office/office6/et"))
  exit(0)
}

fn wpp_click(a voidptr, b voidptr) {
  os.execute(os.resource_abs_path("opt/kingsoft/wps-office/office6/wpp"))
  exit(0)
}

fn pdf_click(a voidptr, b voidptr) {
  os.execute(os.resource_abs_path("opt/kingsoft/wps-office/office6/wpspdf"))
  exit(0)
}

