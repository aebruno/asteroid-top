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

import QtQuick 2.5
import org.asteroid.controls 1.0

Application {
    id: app

    centerColor: "#003e51"
    outerColor: "#666666"

    Item {
        id: mainPage
        anchors.fill: parent

        ProgressCircle {
            anchors.centerIn: parent
            height: mainPage.height 
            width: mainPage.width
            color: "#990000"
            backgroundColor: "#e5e6e8"
            animationEnabled: true
            value: SystemInfo.usedCpu/100
        }

        ProgressCircle {
            anchors.centerIn: parent
            height: mainPage.height-30 
            width: mainPage.width-30
            color: "#990000"
            backgroundColor: "#e5e6e8"
            animationEnabled: true
            value: SystemInfo.usedMemory/100
        }

        Text {
            text: "Load: " + SystemInfo.loadAvg
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height/2.5
            font.pixelSize: width*0.05
        }

        Text {
            text: "<h6>Linux</h6>\n" + SystemInfo.kernelVersion
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height/2
            font.pixelSize: height*0.15
        }

        Text {
            text: "<h6>" + qsTr("Mem:") + "</h6>\n" + Math.round(SystemInfo.usedMemory) + qsTr("%")
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.left: parent.left
            width: parent.width/2.0
            font.pixelSize: width*0.15
        }

        Text {
            text: Math.round(SystemInfo.usedCpu)
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: app.height/8
            anchors.centerIn: parent
        }

        Text {
            text: "<h6>" + qsTr("Disk:") + "</h6>\n" + Math.round(SystemInfo.usedDisk) + qsTr("%")
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.right: parent.right
            width: parent.width/2.0
            font.pixelSize: width*0.15
        }
    }

    Timer {
        id: timer
        interval: 1000
        repeat:  true
        running: true
        triggeredOnStart: true

        onTriggered: {
            SystemInfo.refresh()
        }
    }
}
