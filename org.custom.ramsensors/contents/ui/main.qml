import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.ksysguard.sensors 1.0 as Sensors

Item {
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    property bool showIcon: plasmoid.configuration.showIcon || false
    property bool showLabel: plasmoid.configuration.showLabel !== false
    property string textColor: plasmoid.configuration.textColor || "#ffff00"
    property int fontSize: plasmoid.configuration.fontSize || 30
    property int iconSize: plasmoid.configuration.iconSize || 30

    Plasmoid.compactRepresentation: RowLayout {
        Layout.margins: 5
        spacing: 5

        Image {
            source: Qt.resolvedUrl("../icons/ram.png")
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
                if (showLabel) parts.push("RAM")
                parts.push(ramUsed.formattedValue)
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
        id: ramUsed
        sensorId: "memory/physical/usedPercent"
        updateRateLimit: 1000
    }
}
