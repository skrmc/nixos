import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt.labs.platform as Platform

Variants {
  id: root

  readonly property string wallpaper_path: Platform.StandardPaths.writableLocation(Platform.StandardPaths.HomeLocation) + "/.local/share/wallpapers/default.jpg"
  readonly property int chunk_size: 10

  // if the image is wider than tolerance * screen width when fit to height, we don't scale it
  readonly property real tolerance: 1.1
  readonly property real max_scale: 1.1
  readonly property int move_ms: 600
  readonly property int fade_ms: 800

  model: Quickshell.screens

  PanelWindow {
    id: bg
    screen: modelData
    required property var modelData
    anchors { top: true; bottom: true; left: true; right: true }
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Bottom
    WlrLayershell.namespace: "quickshell:wallpaper"

    property HyprlandMonitor monitor: Hyprland.monitorFor(modelData)
    readonly property int ws_id: (monitor.activeWorkspace?.id ?? 1) - 1
    readonly property int lower: Math.floor(ws_id / root.chunk_size) * root.chunk_size
    readonly property real value_x: (ws_id - lower) / root.chunk_size
    readonly property real effective_value_x: Math.max(0, Math.min(1, value_x))

    property int native_w: screen.width
    property int native_h: screen.height
    readonly property real fit_height_scale: screen.height / Math.max(1, native_h)
    readonly property real expected_width_at_fit: native_w * fit_height_scale
    readonly property bool wide_enough_at_fit: expected_width_at_fit > screen.width * root.tolerance
    readonly property real base_scale: Math.max(screen.width / Math.max(1, native_w), screen.height / Math.max(1, native_h))
    readonly property real display_scale: wide_enough_at_fit ? fit_height_scale : base_scale * root.max_scale
    readonly property real image_width: native_w * display_scale
    readonly property real movable_x_space: Math.max(0, (image_width - screen.width) / 2)

    Item {
      anchors.fill: parent
      clip: true

      Image {
        id: wallpaper
        source: root.wallpaper_path
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        width: bg.image_width
        height: screen.height
        x: -bg.movable_x_space - (bg.effective_value_x - 0.5) * 2 * bg.movable_x_space
        opacity: status === Image.Ready ? 1 : 0
        sourceSize.width: width * (bg.monitor ? bg.monitor.scale : 1)
        sourceSize.height: height * (bg.monitor ? bg.monitor.scale : 1)
        onStatusChanged: if (status === Image.Ready) { bg.native_w = implicitWidth; bg.native_h = implicitHeight }
        Behavior on x { NumberAnimation { duration: root.move_ms; easing.type: Easing.OutCubic } }
        Behavior on opacity { NumberAnimation { duration: root.fade_ms; easing.type: Easing.OutCubic } }
      }
    }
  }
}
