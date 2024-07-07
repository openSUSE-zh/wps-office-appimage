import ui
import os

const (
	win_width  = 512
	win_height = 512
)

struct App {
mut:
	window &ui.Window = unsafe {nil}
}

fn main() {
  if os.args.len > 1 {
    mut f := os.args[1].to_lower()
    if f.contains("~") {
       f.replace("~", os.home_dir())
       println(f)
    }
    if f.ends_with(".doc") || f.ends_with(".docx") {
       mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/wps"))
       process.set_args([f])
       process.run()
    }
    if f.ends_with(".xls") || f.ends_with(".xlsx") {
       mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/et"))
       process.set_args([f])
       process.run()
    }
    if f.ends_with(".ppt") || f.ends_with(".pptx") {
       mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/wpp"))
       process.set_args([f])
       process.run()
    }
    if f.ends_with(".pdf") {
       mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/wpspdf"))
       process.set_args([f])
       process.run()
    }
  } else {
    mut wps := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-wpsmain.png")
    mut et := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-etmain.png")
    mut wpp := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-wppmain.png")
    mut pdf := os.resource_abs_path("usr/share/icons/hicolor/256x256/mimetypes/wps-office2019-pdfmain.png")

	  mut app := &App{}

	  app.window = ui.window(
		  width: win_width
		  height: win_height
		  title: 'WPS Office Launcher'
		  mode: .resizable
		  children: [
			  ui.row(
				  children: [
            ui.column(
              children: [
					      ui.picture(width: 256, height: 256, path: wps, on_click: click_wps),
                ui.picture(width: 256, height: 256, path: et, on_click: click_et)
              ]
            ),
            ui.column(
              children: [
                ui.picture(width: 256, height: 256, path: wpp, on_click: click_wpp),
                ui.picture(width: 256, height: 256, path: pdf, on_click: click_wpspdf)
              ]
            ),
          ]
        ),
		  ]
	  )
	  ui.run(app.window)
  }
}

fn click_wps(pic &ui.Picture) {
  mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/wps"))
  process.run()
}

fn click_et(pic &ui.Picture) {
  mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/et"))
  process.run()
}

fn click_wpp(pic &ui.Picture) {
  mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/wpp"))
  process.run()
}

fn click_wpspdf(pic &ui.Picture) {
  mut process := os.new_process(os.resource_abs_path("opt/kingsoft/wps-office/office6/wpspdf"))
  process.run()
}

