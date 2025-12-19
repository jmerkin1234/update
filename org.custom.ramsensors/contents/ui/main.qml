import QtQuick 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.ksysguard.sensors 1.0 as Sensors

PlasmoidItem {
    id: root

    property bool showIcon: Plasmoid.configuration.showIcon || false
    property bool showLabel: Plasmoid.configuration.showLabel !== false
    property string textColor: Plasmoid.configuration.textColor || "#ffff00"
    property int fontSize: Plasmoid.configuration.fontSize || 30
    property int iconSize: Plasmoid.configuration.iconSize || 30

    compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/ram.png")
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
                if (root.showLabel) parts.push("RAM")
                parts.push(ramUsed.formattedValue)
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
        id: ramUsed
        sensorId: "memory/physical/usedPercent"
        updateRateLimit: 1000
    }
}
