# Custom KDE Plasma System Monitor Widgets

## Overview
Three custom plasma widgets for monitoring system resources in the KDE panel:
- **CPU Sensors** - Shows CPU usage and temperature
- **GPU Sensors** - Shows GPU usage, temperature, and fan speed
- **RAM Sensors** - Shows RAM usage percentage

## File Structure

### CPU Sensors Widget
Location: `/home/justin/.local/share/plasma/plasmoids/org.custom.cpusensors/`

```
org.custom.cpusensors/
├── contents/
│   ├── config/
│   │   └── main.xml                  # Configuration schema
│   ├── icons/
│   │   └── cpu.png                   # Custom CPU icon
│   └── ui/
│       ├── main.qml                  # Main widget code
│       └── configGeneral.qml         # Configuration UI
└── metadata.json                     # Widget metadata
```

### GPU Sensors Widget
Location: `/home/justin/.local/share/plasma/plasmoids/org.custom.gpusensors/`

```
org.custom.gpusensors/
├── contents/
│   ├── config/
│   │   └── main.xml                  # Configuration schema
│   ├── icons/
│   │   └── gpu.png                   # Custom GPU icon
│   └── ui/
│       ├── main.qml                  # Main widget code
│       └── configGeneral.qml         # Configuration UI
└── metadata.json                     # Widget metadata
```

### RAM Sensors Widget
Location: `/home/justin/.local/share/plasma/plasmoids/org.custom.ramsensors/`

```
org.custom.ramsensors/
├── contents/
│   ├── config/
│   │   └── main.xml                  # Configuration schema
│   ├── icons/
│   │   └── ram.png                   # Custom RAM icon
│   └── ui/
│       ├── main.qml                  # Main widget code
│       └── configGeneral.qml         # Configuration UI
└── metadata.json                     # Widget metadata
```

## Configuration Options

### CPU Sensors
- **Show icon** - Toggle CPU icon display
- **Show 'CPU' label** - Toggle "CPU" text label
- **Show Usage %** - Toggle CPU usage percentage
- **Show Temperature** - Toggle CPU temperature
- **Font size** - Text size (8-72pt, default: 30)
- **Icon size** - Icon size (8-72px, default: 30)
- **Text color** - Color in hex format (default: #00ff00 - green)

### GPU Sensors
- **GPU index** - Which GPU to monitor (0, 1, or 2, default: 1)
- **Show icon** - Toggle GPU icon display
- **Show 'GPU' label** - Toggle "GPU" text label
- **Show Usage %** - Toggle GPU usage percentage
- **Show Temperature** - Toggle GPU temperature
- **Show Fan Speed** - Toggle GPU fan speed
- **Font size** - Text size (8-72pt, default: 30)
- **Icon size** - Icon size (8-72px, default: 30)
- **Text color** - Color in hex format (default: #00ffff - cyan)

### RAM Sensors
- **Show icon** - Toggle RAM icon display
- **Show 'RAM' label** - Toggle "RAM" text label
- **Font size** - Text size (8-72pt, default: 30)
- **Icon size** - Icon size (8-72px, default: 30)
- **Text color** - Color in hex format (default: #ffff00 - yellow)

## Sensor IDs Used

### CPU
- Usage: `cpu/all/usage`
- Temperature: `cpu/all/averageTemperature`

### GPU
- Usage: `gpu/gpu{N}/usage` (where {N} is GPU index 0-2)
- Temperature: `gpu/gpu{N}/temperature`
- Fan: `gpu/gpu{N}/fan1`

### RAM
- Usage: `memory/physical/usedPercent`

## Hardware Monitoring Setup

### Motherboard Sensors (ROG Strix X299-E Gaming)
The nct6775 kernel module is loaded for Nuvoton NCT6796D sensor chip support.

Module loaded via `/etc/modules`:
```
nct6775
```

To manually load: `sudo modprobe nct6775`

## Customizing Icons

Icons are stored in each widget's `contents/icons/` directory:
- CPU: `/home/justin/.local/share/plasma/plasmoids/org.custom.cpusensors/contents/icons/cpu.png`
- GPU: `/home/justin/.local/share/plasma/plasmoids/org.custom.gpusensors/contents/icons/gpu.png`
- RAM: `/home/justin/.local/share/plasma/plasmoids/org.custom.ramsensors/contents/icons/ram.png`

To replace icons:
1. Save new PNG image to the appropriate path above
2. Restart plasmashell: `killall plasmashell && plasmashell &`

## Key Files to Edit

### main.qml
Main widget display logic. Key sections:
- Properties (lines 10-16): Widget configuration properties
- Layout (lines 17-41): Widget visual structure with icon and text
- Sensors (lines 43-51): KSysGuard sensor definitions

### configGeneral.qml
Configuration UI. Key sections:
- Property aliases (lines 6-12): Bind UI controls to config values
- CheckBoxes: Toggle options for display elements
- SpinBoxes: Numeric inputs for sizes
- TextField: Text color input

### main.xml
Configuration schema defining all available settings with defaults.

## Applying Changes

After modifying any QML or configuration files:
```bash
killall plasmashell && plasmashell &
```

Or reload individual widgets by:
1. Right-click widget → Remove
2. Right-click panel → Add Widgets
3. Search for CPU/GPU/RAM Sensors
4. Add back to panel

## Display Format

Widgets display in format: `[ICON] LABEL VALUE VALUE`

Examples:
- `[CPU icon] CPU 45% 67°C`
- `[GPU icon] GPU 32% 54°C 1200RPM`
- `[RAM icon] RAM 68%`

Label and icon are both toggleable. With label off and icon on:
- `[CPU icon] 45% 67°C`

## Technical Details

### QML Components Used
- `QtQuick.Layouts.RowLayout` - Horizontal layout
- `Image` - Custom icon display with Qt.resolvedUrl()
- `Text` - Sensor value display
- `org.kde.ksysguard.sensors.Sensor` - System sensor access

### Configuration System
- `main.xml` - XML schema using KConfig (kcfg)
- Property bindings: `plasmoid.configuration.propertyName`
- Two-way binding in config UI via property aliases

### Widget Structure
- `Plasmoid.compactRepresentation` - Panel display
- `Layout.margins: 5` - Padding around widget
- `spacing: 5` - Space between icon and text
- `fillMode: Image.PreserveAspectFit` - Icon scaling

## Troubleshooting

### Icons not showing
1. Verify icon files exist:
   ```bash
   ls -la /home/justin/.local/share/plasma/plasmoids/org.custom.*/contents/icons/
   ```
2. Check "Show icon" is enabled in widget configuration
3. Restart plasmashell

### Sensors showing blank values
1. Check sensor availability:
   ```bash
   ksysguardd
   ```
   Then type: `monitors` to see all available sensors
2. Verify sensor IDs in main.qml match available sensors
3. For GPU: ensure correct GPU index (default is 1, not 0)

### Motherboard fan sensors not working
1. Load kernel module: `sudo modprobe nct6775`
2. Verify sensors: `sensors`
3. Add to `/etc/modules` for persistence

### Widget configuration not saving
1. Check file permissions on config files
2. Verify main.xml syntax is valid XML
3. Ensure property aliases in configGeneral.qml match config entries

### Text overlapping adjacent widgets
- Increase `Layout.margins` value in main.qml (line 21)
- Currently set to 5 pixels

### Text getting cut off when values change
- Fixed with `Layout.fillWidth: true` and `Layout.minimumWidth: implicitWidth`
- This ensures widget reserves enough space for full text (lines 46-47 in main.qml)
- Prevents truncation when values go from single to double digits (e.g., 9% → 10%)

## Development Notes

### Adding New Sensors
1. Add sensor definition in main.qml:
   ```qml
   Sensors.Sensor {
       id: newSensor
       sensorId: "path/to/sensor"
       updateRateLimit: 1000
   }
   ```
2. Add to text display logic:
   ```qml
   if (showNewSensor) parts.push(newSensor.formattedValue)
   ```
3. Add configuration in main.xml and configGeneral.qml

### Changing Colors
Edit the `textColor` default in main.xml or configure via UI.
Colors use hex format: `#RRGGBB`
- Red: `#ff0000`
- Green: `#00ff00`
- Blue: `#0000ff`
- White: `#ffffff`
- Yellow: `#ffff00`
- Cyan: `#00ffff`
- Magenta: `#ff00ff`

### Adjusting Update Rate
Change `updateRateLimit` in Sensor definitions (in milliseconds):
- Current: 1000ms (1 second)
- Faster: 500ms
- Slower: 2000ms

## System Information
- KDE Plasma Version: 5.27.11
- Qt Version: 5.15
- Platform: Linux
- Motherboard: ROG Strix X299-E Gaming
- Sensor Chip: Nuvoton NCT6796D

## Files Modified/Created
All custom files are in `/home/justin/.local/share/plasma/plasmoids/`
No system files were modified.

## Backup Command
```bash
tar -czf ~/plasma-widgets-backup.tar.gz ~/.local/share/plasma/plasmoids/org.custom.*
```

## Restore Command
```bash
tar -xzf ~/plasma-widgets-backup.tar.gz -C ~/
killall plasmashell && plasmashell &
```
