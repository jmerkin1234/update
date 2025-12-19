import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.5 as Kirigami

Kirigami.FormLayout {
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
        text: "Show 'RAM' label"
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
        placeholderText: "#ffff00"
    }
}
