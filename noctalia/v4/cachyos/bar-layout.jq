# Reuse the widgets supplied by CachyOS, changing only their placement and the
# two presentation details we customize.
.bar.widgets as $widgets
| ([$widgets.left[], $widgets.center[], $widgets.right[]]
   | map({key: .id, value: .})
   | from_entries) as $by_id
| .general.enableShadows = false
| .bar.backgroundOpacity = 0.5
| .bar.capsuleOpacity = 0
| .bar.enableExclusionZoneInset = false
| .bar.useSeparateOpacity = true
| .bar.outerCorners = false
| .bar.widgetSpacing = 0
| .bar.widgets.left = [
    ($by_id.ActiveWindow + {
      showIcon: true,
      showText: false
    }),
    {id: "Spacer", width: 6},
    $by_id.Workspace
  ]
| .bar.widgets.center = []
| .bar.widgets.right = [
    $by_id.SystemMonitor,
    {
      id: "CustomButton",
      icon: "",
      showIcon: false,
      textCommand: "printf '|'",
      textStream: false,
      textIntervalMs: 60000,
      textCollapse: "",
      hideMode: "alwaysExpanded",
      maxTextLength: {
        horizontal: 1,
        vertical: 1
      },
      leftClickExec: "",
      rightClickExec: "",
      middleClickExec: "",
      showExecTooltip: false,
      showTextTooltip: false,
      generalTooltipText: ""
    },
    $by_id.Brightness,
    {id: "Spacer", width: 6},
    $by_id.Volume,
    {id: "Spacer", width: 6},
    $by_id.Battery,
    {id: "Spacer", width: 6},
    $by_id.NotificationHistory,
    {id: "Spacer", width: 6},
    $by_id.ControlCenter,
    {id: "Spacer", width: 6},
    ($by_id.Clock + {
      formatHorizontal: "HH:mm"
    })
  ]
