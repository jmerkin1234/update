import QtQuick
import QtQuick.Layouts
import org.kde.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.ksysguard.sensors as Sensors

PlasmoidItem {
    id: root

    property int gpuIndex: Plasmoid.configuration.gpuIndex || 1
    property bool showUsage: Plasmoid.configuration.showUsage
    property bool showTemp: Plasmoid.configuration.showTemp
    property bool showFan: Plasmoid.configuration.showFan
    property bool showIcon: Plasmoid.configuration.showIcon || false
    property bool showLabel: Plasmoid.configuration.showLabel !== false
    property string textColor: Plasmoid.configuration.textColor || "#00ffff"
    property int fontSize: Plasmoid.configuration.fontSize || 30
    property int iconSize: Plasmoid.configuration.iconSize || 30

    compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/gpu.png")
            width: root.iconSize
            height: root.iconSize
            Layout.preferredWidth: root.iconSize
            Layout.preferredHeight: root.iconSize
            visible: root.showIcon
            fillMode: Image.PreserveAspectFit
        }

        Text {
            text: {
                let parts = []
                if (root.showLabel) parts.push("GPU")
                if (root.showUsage) parts.push(gpuUsage.formattedValue)
                if (root.showTemp) parts.push(gpuTemp.formattedValue)
                if (root.showFan) parts.push(gpuFan.formattedValue)
                return parts.join(" ")
            }
            font.pointSize: root.fontSize
            color: root.textColor
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.minimumWidth: implicitWidth
            visible: text.length > 0
        }
    }

    Sensors.Sensor {
        id: gpuUsage
        sensorId: "gpu/gpu" + root.gpuIndex + "/usage"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: gpuTemp
        sensorId: "gpu/gpu" + root.gpuIndex + "/temperature"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: gpuFan
        sensorId: "gpu/gpu" + root.gpuIndex + "/fan1"
        updateRateLimit: 1000
    }
}
