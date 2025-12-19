import QtQuick
import QtQuick.Layouts
import org.kde.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.ksysguard.sensors as Sensors

PlasmoidItem {
    id: root

    property bool showUsage: Plasmoid.configuration.showUsage
    property bool showTemp: Plasmoid.configuration.showTemp
    property bool showIcon: Plasmoid.configuration.showIcon || false
    property bool showLabel: Plasmoid.configuration.showLabel !== false
    property string textColor: Plasmoid.configuration.textColor || "#00ff00"
    property int fontSize: Plasmoid.configuration.fontSize || 30
    property int iconSize: Plasmoid.configuration.iconSize || 30

    compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/cpu.png")
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
                if (root.showLabel) parts.push("CPU")
                if (root.showUsage) parts.push(cpuUsage.formattedValue)
                if (root.showTemp) parts.push(cpuTemp.formattedValue)
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
        id: cpuUsage
        sensorId: "cpu/all/usage"
        updateRateLimit: 1000
    }

    Sensors.Sensor {
        id: cpuTemp
        sensorId: "cpu/all/averageTemperature"
        updateRateLimit: 1000
    }
}
