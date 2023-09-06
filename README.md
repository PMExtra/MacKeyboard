# MacKeyboard

将 macOS 快捷键带到 Windows 平台。

## 开始之前

该项目是一个 [AutoHotKey](https://www.autohotkey.com/) 脚本，建议安装 [AutoHotKey V2](https://www.autohotkey.com/download/ahk-v2.exe) 使用。

### 交换 Command 与 Option 键位

如需交换 `Command` (`Windows` / `Meta`) 与 `Option` (`Alt`) 按键键位，可以使用 [SharpKeys](https://github.com/randyrants/sharpkeys) 工具，导入 `SharpKeys.skl` 配置文件。

> SharpKeys 是一个配置工具，它会将键位映射导入 Windows 注册表，重启系统后生效。SharpKeys 自身不作为服务，所以无需随系统启动。

> 大多数键盘（包括笔记本电脑内置键盘）的键帽都是可拆卸的。在 SharpKeys 映射键位之后，您可以拆卸并交换键帽以让键帽标识符合实际键位。

## 使用方法

安装 AutoHotKey 之后，双击 `MacKeyboard.ahk` 文件即可启动。

您也可以添加计划任务，实现开机自动启动和崩溃自动恢复。在 Windows 计划任务程序 中，导入 `Scheduler.xml` ，并在 `Actions` 标签页中，根据实际情况修改 `AutoHotkeyU64.exe` 和 `MacKeyboard.ahk` 的路径。

> AutoHotKeys 是一个后台服务，它通过键盘钩子拦截键盘输入并进行快捷键的映射，因此必须时刻保持运行才能映射快捷键。
