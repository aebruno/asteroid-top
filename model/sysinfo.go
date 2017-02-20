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

package model

import (
	"fmt"
	"time"

	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/disk"
	"github.com/shirou/gopsutil/host"
	"github.com/shirou/gopsutil/load"
	"github.com/shirou/gopsutil/mem"
	"github.com/therecipe/qt/core"
)

//go:generate qtmoc
type SystemInfoModel struct {
	core.QObject

	_ string  `property:"kernelVersion"`
	_ float64 `property:"usedMemory"`
	_ float64 `property:"usedDisk"`
	_ float64 `property:"usedCpu"`
	_ string  `property:"loadAvg"`
	_ func()  `signal:"refresh"`
	_ func()  `constructor:"init"`
}

// Initialize model
func (model *SystemInfoModel) init() {
	// Connect to refresh signal
	model.ConnectRefresh(model.refresh)

	kernel, _ := host.KernelVersion()
	model.SetKernelVersion(kernel)
	model.refresh()
}

// Refresh model and update system info properties
func (model *SystemInfoModel) refresh() {
	v, _ := mem.VirtualMemory()
	d, _ := disk.Usage("/")
	l, _ := load.Avg()
	c, _ := cpu.Percent(500*time.Millisecond, false)

	model.SetUsedMemory(v.UsedPercent)
	model.SetUsedDisk(d.UsedPercent)
	model.SetUsedCpu(c[0])
	model.SetLoadAvg(fmt.Sprintf("%.1f, %.1f, %.1f", l.Load1, l.Load5, l.Load15))
}
