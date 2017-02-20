===============================================================================
Asteroid Top
===============================================================================

Asteroid Top is an app for `AsteroidOS <https://asteroidos.org>`_ written in
Go. It displays the Linux kernel version, CPU load, memory usage, disk usage,
and load averages (1,5,15 min). This app is mean to serve as an example of
writing Go apps for AsteroidOS.

-------------------------------------------------------------------------------
Building from source
-------------------------------------------------------------------------------

*These instructions assume you're running Linux*

1. Install Go >= 1.7.1 and setup a proper `GOPATH <https://golang.org/doc/code.html#GOPATH>`_ 

2. Install Qt 5.7.0 the official `prebuilt package <https://download.qt.io/official_releases/qt/5.7/5.7.0/qt-opensource-linux-x64-android-5.7.0.run>`_

3. Install `Asteroid SDK <https://asteroidos.org/wiki/creating-an-asteroid-app/>`_

4. Make sure to source the oecore script before each build (something like)::

    $ source /usr/local/oecore-x86_64/environment-setup-armv7ve-neon-oe-linux-gnueabi

5. Clone asteroid-top and download dependencies::

    $ git clone https://github.com/aebruno/asteroid-top.git
    $ cd asteroid-top
    $ go get github.com/shirou/gopsutil 

6. Download and install Go QT bindings. This will clone
   https://github.com/therecipe/qt and checkout the specific version that has
   been known to work with asteroid-top::

    $ ./build.sh bootstrap-qt

7. Run qtmoc, qtrcc and qtminimal::

    $ ./build.sh prep

8. Compile armv7ve binary for Asteroid::

    $ ./build.sh compile

9. Install the app on the watch::

    $ adb push asteroid-top /usr/bin/
    $ adb push asteroid-top.desktop /usr/share/applications/

-------------------------------------------------------------------------------
License
-------------------------------------------------------------------------------

Copyright (C) 2017 Andrew E. Bruno

asteroid-top is free software: you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.
