import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.FormLayout {
    property alias cfg_gpuIndex: gpuIndexSpinBox.value
    property alias cfg_showUsage: showUsageCheck.checked
    property alias cfg_showTemp: showTempCheck.checked
    property alias cfg_showFan: showFanCheck.checked
    property alias cfg_showIcon: showIconCheck.checked
    property alias cfg_showLabel: showLabelCheck.checked
    property alias cfg_fontSize: fontSizeSpinBox.value
    property alias cfg_iconSize: iconSizeSpinBox.value
    property alias cfg_textColor: colorField.text

    SpinBox {
        id: gpuIndexSpinBox
        Kirigami.FormData.label: "GPU index (0, 1, or 2):"
        from: 0
        to: 2
    }

    CheckBox {
        id: showIconCheck
        text: "Show icon"
        Kirigami.FormData.label: "Display:"
    }

    CheckBox {
        id: showLabelCheck
        text: "Show 'GPU' label"
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

    CheckBox {
        id: showFanCheck
        text: "Show Fan Speed"
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
        placeholderText: "#00ffff"
    }
}
