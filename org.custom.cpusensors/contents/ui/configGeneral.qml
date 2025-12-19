import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.5 as Kirigami

Kirigami.FormLayout {
    property alias cfg_showUsage: showUsageCheck.checked
    property alias cfg_showTemp: showTempCheck.checked
    property alias cfg_showIcon: showIconCheck.checked
    property alias cfg_showLabel: showLabelCheck.checked
    property alias cfg_fontSize: fontSizeSpinBox.value
    property alias cfg_iconSize: iconSizeSpinBox.value
    property alias cfg_textColor: colorField.text

    CheckBox {
        id: showIconCheck
        text: "Show icon"
        Kirigami.FormData.label: "Display:"
    }

    CheckBox {
        id: showLabelCheck
        text: "Show 'CPU' label"
    }

    CheckBox {
        id: showUsageCheck
        text: "Show Usage %"
        Kirigami.FormData.label: "Metrics:"
    }

    CheckBox {
        id: showTempCheck
        text: "Show Temperature"
    }

    SpinBox {
        id: fontSizeSpinBox
        Kirigami.FormData.label: "Font size:"
        from: 8
        to: 72
    }

    SpinBox {
        id: iconSizeSpinBox
        Kirigami.FormData.label: "Icon size:"
        from: 8
        to: 72
    }

    TextField {
        id: colorField
        Kirigami.FormData.label: "Text color:"
        placeholderText: "#00ff00"
    }
}
