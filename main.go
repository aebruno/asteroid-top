// Copyright 2017 Andrew E. Bruno
//
// This file is part of asteroid-top.
//
// asteroid-top is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// asteroid-top is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with asteroid-top.  If not, see <http://www.gnu.org/licenses/>.

package main

import (
	"os"

	"github.com/aebruno/asteroid-top/model"
	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/quick"
)

const (
	Version = "0.0.1"
)

func main() {
	os.Setenv("QT_QPA_PLATFORM", "wayland")
	os.Setenv("EGL_PLATFORM", "wayland")
	os.Setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

	gui.NewQGuiApplication(len(os.Args), os.Args)
	core.QCoreApplication_SetApplicationVersion(Version)
	core.QCoreApplication_SetOrganizationName("")
	core.QCoreApplication_SetApplicationName("asteroid-top")
	var view = quick.NewQQuickView(nil)

	var model = model.NewSystemInfoModel(nil)

	view.RootContext().SetContextProperty("SystemInfo", model)
	view.SetSource(core.NewQUrl3("qrc:///qml/main.qml", 0))
	view.ShowFullScreen()
	gui.QGuiApplication_Exec()
}
