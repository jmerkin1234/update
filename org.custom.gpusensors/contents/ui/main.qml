import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.ksysguard.sensors 1.0 as Sensors

Item {
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    property int gpuIndex: plasmoid.configuration.gpuIndex || 1
    property bool showUsage: plasmoid.configuration.showUsage
    property bool showTemp: plasmoid.configuration.showTemp
    property bool showFan: plasmoid.configuration.showFan
    property bool showIcon: plasmoid.configuration.showIcon || false
    property bool showLabel: plasmoid.configuration.showLabel !== false
    property string textColor: plasmoid.configuration.textColor || "#00ffff"
    property int fontSize: plasmoid.configuration.fontSize || 30
    property int iconSize: plasmoid.configuration.iconSize || 30

    Plasmoid.compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/gpu.png")
            width: iconSize
            height: iconSize
            Layout.preferredWidth: iconSize
            Layout.preferredHeight: iconSize
            visible: showIcon
            fillMode: Image.PreserveAspectFit
        }

        Text {
            text: {
                let parts = []
                if (showLabel) parts.push("GPU")
                if (showUsage) parts.push(gpuUsage.formattedValue)
                if (showTemp) parts.push(gpuTemp.formattedValue)
                if (showFan) parts.push(gpuFan.formattedValue)
                return parts.join(" ")
            }
            font.pointSize: fontSize
            color: textColor
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.minimumWidth: implicitWidth
            visible: text.length > 0
        }
    }

    Sensors.Sensor {
        id: gpuUsage
        sensorId: "gpu/gpu" + gpuIndex + "/usage"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: gpuTemp
        sensorId: "gpu/gpu" + gpuIndex + "/temperature"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: gpuFan
        sensorId: "gpu/gpu" + gpuIndex + "/fan1"
        updateRateLimit: 1000
    }
}
