---@meta

---Generated from the Ethos Doxygen HTML reference in lua-doc/.
---Constants documented under the base namespace are emitted as globals because the examples use them that way.

---@alias Mask table
---@alias Rect table

---@class SystemGetMemoryUsageResult
---@field mainStackAvailable integer # Memory available for the main stack (bytes)
---@field ramAvailable integer # Memory available for the whole system (bytes)
---@field luaRamAvailable integer # Memory available for Lua scripts execution (bytes)
---@field luaBitmapsRamAvailable integer # Memory available for loading bitmaps in Lua scripts (bytes)
local SystemGetMemoryUsageResult = {}

---@class SystemGetVersionResult
---@field board string # board name, i.e. "X20S"
---@field version string # version
---@field major number # version major (i.e. 1 if version is "1.2.0-RC1")
---@field minor number # version minor (i.e. 2 if version is "1.2.0-RC1")
---@field revision number # version revision (i.e. 0 if version is "1.2.0-RC1")
---@field suffix string # version suffix (i.e. "RC1" if version is "1.2.0-RC1")
---@field lcdWidth number # LCD Width
---@field lcdHeight number # LCD Height
---@field simulation boolean
---@field serial string
local SystemGetVersionResult = {}

---@class Bitmap
local Bitmap = {}

---Return the bitmap height.
---Since: 1.1.0
---@return integer height # height
function Bitmap:height() end

---Return the rotated bitmap.
---Since: 1.5.9
---@param angle number
---@return Bitmap result # the rotated bitmap
function Bitmap:rotate(angle) end

---Return the bitmap width.
---Since: 1.1.0
---@return integer width # width
function Bitmap:width() end

---@class Channel
local Channel = {}

---Get / Set the center percent of the channel.
---Since: 1.6.0
---@param center? number
---@return number center # center
function Channel:center(center) end

---Get / Set the direction of the channel (1 is normal / -1 reverse)
---Since: 1.6.0
---@param direction? integer
---@return integer direction # direction
function Channel:direction(direction) end

---Get / Set the max percent of the channel.
---Since: 1.6.0
---@param max? number
---@return number max # max
function Channel:max(max) end

---Get / Set the min percent of the channel.
---Since: 1.6.0
---@param min? number
---@return number min # min
function Channel:min(min) end

---Get / Set the channel name.
---Since: 1.6.0
---@param name? string
---@return string name # name
function Channel:name(name) end

---Get / Set the pwm center value of the channel.
---Since: 1.6.0
---@param center? number
---@return number center # center
function Channel:pwmCenter(center) end

---Get / Set the Slow-down value of the channel.
---Since: 1.6.4
---@param slowUp? number
---@return number slowUp # slowUp
function Channel:slowDown(slowUp) end

---Get / Set the Slow-up value of the channel.
---Since: 1.6.4
---@param slowUp? number
---@return number slowUp # slowUp
function Channel:slowUp(slowUp) end

---@class ChoiceLib: FormFieldLib
local ChoiceLib = {}

---Set the field help text.
---Since: 1.5.10
---@param text string
function ChoiceLib:help(text) end

---Set the choice menu title.
---Since: 1.6.1
---@param text string
function ChoiceLib:title(text) end

---Set the choice values.
---Since: 1.6.2
---@param values table # table of all possible values
function ChoiceLib:values(values) end

---@class CrsfSensor
local CrsfSensor = {}

---Pop a CRSF frame.
---Since: 1.6.0
---@param commandFilterMin? integer
---@param commandFilterMax? integer
---@return integer command
---@return table data
function CrsfSensor:popFrame(commandFilterMin, commandFilterMax) end

---Push a CRSF frame.
---Since: 1.4.0
---@param command integer
---@param data table
---@return boolean result # result
function CrsfSensor:pushFrame(command, data) end

---@class Curve
local Curve = {}

---Get / Set the custom curve mode (1 is easyMode / -1 not)
---Since: 1.1.0
---@param easyMode? boolean
---@return boolean easyMode # easyMode
function Curve:easyMode(easyMode) end

---Get / Set the exponent of the curve.
---Since: 1.1.0
---@param exponent? integer
---@return integer exponent # exponent
function Curve:exponent(exponent) end

---Get / Set the type of the function curve.
---Since: 1.1.0
---@param functionType? integer
---@return integer functionType # functionType
function Curve:functionType(functionType) end

---Get / Set the curve name.
---Since: 1.1.0
---@param name? string
---@return string name # name
function Curve:name(name) end

---Get / Set the offset of the exponent curve.
---Since: 1.1.0
---@param offset? integer
---@return integer offset # offset
function Curve:offset(offset) end

---Get / Set the point of the custom curve by index.
---Since: 1.1.0
---@param index integer
---@param x? number
---@param y? number
---@return number x
---@return number y
function Curve:point(index, x, y) end

---Get / Set the points count of the custom curve.
---Since: 1.1.0
---@param pointsCount? integer
---@return integer pointsCount # pointsCount
function Curve:pointsCount(pointsCount) end

---Get / Set the custom curve smooth (1 is smooth / -1 not)
---Since: 1.1.0
---@return integer smooth # smooth
function Curve:smooth() end

---Get / Set the type of the curve.
---Since: 1.1.0
---@param type? integer
---@return integer type # type
function Curve:type(type) end

---Get / Set the weight of the exponent curve.
---Since: 1.1.0
---@param weight? integer
---@return integer weight # weight
function Curve:weight(weight) end

---@class Dialog
local Dialog = {}

---@class ExpansionPanel
local ExpansionPanel = {}

---Add a new line to the expansion panel.
---Since: 1.5.4
---@param label string # the line label
---@param separator? boolean # separator after the line
---@return FormLine line # line
function ExpansionPanel:addLine(label, separator) end

---Clear the expansion panel.
---Since: 1.5.4
function ExpansionPanel:clear() end

---Set a handler called when an event (EVT_CLOSE / EVT_OPEN) is received.
---Since: 1.5.10
---@param handler fun(...):any
function ExpansionPanel:event(handler) end

---Open / close the expansion panel.
---Since: 1.5.0
---@param state boolean
function ExpansionPanel:open(state) end

---@class FormFieldLib
local FormFieldLib = {}

---Enable / disable the field.
---Since: 1.1.0
---@param enabled boolean
function FormFieldLib:enable(enabled) end

---Give the focus to the field.
---Since: 1.5.10
function FormFieldLib:focus() end

---Get the field rect.
---Since: 1.5.14
---@return Rect rect # rect
function FormFieldLib:rect() end

---@class FormLine
local FormLine = {}

---@class FrSkyStaticTextLib
local FrSkyStaticTextLib = {}

---Set the text color.
---Since: 1.5.16
---@param color integer
function FrSkyStaticTextLib:color(color) end

---Set the text value.
---Since: 1.5.16
---@param value string
function FrSkyStaticTextLib:value(value) end

---@class GlassesLayout
local GlassesLayout = {}

---Clear layout and display text.
---Since: 26.1.0
---@param text string
function GlassesLayout:clearAndDisplay(text) end

---Clear layout and display text at position x, y with optional extra commands.
---Since: 26.1.0
---@param params any # table with elements: x (integer): left y (integer): top text (text): text commands (table): table of extra commands (font, text, bitmap)
function GlassesLayout:clearAndDisplayExtended(params) end

---@class LogicSwitch
local LogicSwitch = {}

---Get / set the active condition of the logic switch.
---Since: 1.1.0
---@param condition? any
---@return Source condition # condition
function LogicSwitch:activeCondition(condition) end

---Get / set the logic switch delay OFF.
---Since: 26.1.0
---@param delayOff? integer
---@return integer delayOff # delayOff
function LogicSwitch:delayOff(delayOff) end

---Get / set the logic switch delay ON.
---Since: 26.1.0
---@param delayOn? integer
---@return integer delayOn # delayOn
function LogicSwitch:delayOn(delayOn) end

---Get / set the function of the logic switch.
---Since: 26.1.0
---@param function_value? integer
---@return integer function_value # function
LogicSwitch["function"] = function(self, function_value) end

---Get / set the logic switch max duration.
---Since: 26.1.0
---@param maxDuration? integer
---@return integer maxDuration # maxDuration
function LogicSwitch:maxDuration(maxDuration) end

---Get / set the logic switch min duration.
---Since: 26.1.0
---@param minDuration? integer
---@return integer minDuration # minDuration
function LogicSwitch:minDuration(minDuration) end

---Get / set the logic switch name.
---Since: 26.1.0
---@param name? string
---@return string name # name
function LogicSwitch:name(name) end

---Get / set the logic switch negative attribute.
---Since: 26.1.0
---@param negative? boolean
---@return boolean negative # negative
function LogicSwitch:negative(negative) end

---Get the logic switch state.
---Since: 26.1.0
---@return boolean state # state
function LogicSwitch:state() end

---Get / set the test values of the logic switch.
---Since: 26.1.0
---@param values? table
---@return table values # values
function LogicSwitch:values(values) end

---@class LuaBitmapBase
local LuaBitmapBase = {}

---@class LuaButton
local LuaButton = {}

---Give the focus to the button.
---Since: 1.5.10
function LuaButton:focus() end

---Enable or disable the button.
---@param enabled boolean
function LuaButton:enable(enabled) end

---@class LuaCrsfSensor
local LuaCrsfSensor = {}

---@class LuaMultimoduleSensor
local LuaMultimoduleSensor = {}

---@class LuaSPortFrame
local LuaSPortFrame = {}

---Get / set the appId of the frame.
---Since: 1.1.0
---@param appId? integer
---@return integer appId # appId
function LuaSPortFrame:appId(appId) end

---Get / set the band.
---Since: 1.1.0
---@param band? integer
---@return integer band # band
function LuaSPortFrame:band(band) end

---Get / set the module.
---Since: 1.1.0
---@param module? integer
---@return integer module # module
function LuaSPortFrame:module(module) end

---Get / set the physId of the frame.
---Since: 1.1.0
---@param physId? integer
---@return integer physId # physId
function LuaSPortFrame:physId(physId) end

---Get / set the primId of the frame.
---Since: 1.1.0
---@param primId? integer
---@return integer primId # primId
function LuaSPortFrame:primId(primId) end

---Get / set the rx index.
---Since: 1.1.0
---@param rx? integer
---@return integer rx # rx
function LuaSPortFrame:rx(rx) end

---Get / set the value of the frame.
---Since: 1.1.0
---@param value? integer
---@return integer value # value
function LuaSPortFrame:value(value) end

---@class LuaSPortSensor
local LuaSPortSensor = {}

---Get / set the appId of sensor.
---Since: 1.1.0
---@param appId? integer
---@return integer appId # appId
function LuaSPortSensor:appId(appId) end

---Get / set the band.
---Since: 1.1.0
---@param band? integer
---@return integer band # band
function LuaSPortSensor:band(band) end

---Return true if the sensor is alive and updates its module / band / rx / appId / physId.
---Since: 1.6.3
---@return boolean result # result
function LuaSPortSensor:discover() end

---Get a parameter if received from the S.Port Sensor.
---Since: 1.1.0
---@return boolean result # result
function LuaSPortSensor:getParameter() end

---Set / unset the S.Port Sensor IDLE mode.
---Since: 1.1.0
---@param state? boolean
---@return boolean result # result
function LuaSPortSensor:idle(state) end

---Get / set the module.
---Since: 1.1.0
---@param module? integer
---@return integer module # module
function LuaSPortSensor:module(module) end

---Get / set the physId of sensor.
---Since: 1.1.0
---@param physId? integer
---@return integer physId # physId
function LuaSPortSensor:physId(physId) end

---Pop a S.Port frame.
---Since: 1.1.0
---@return LuaSPortFrame frame # frame
function LuaSPortSensor:popFrame() end

---Push a S.Port frame.
---Since: 1.1.0
---@param frame LuaSPortFrame # or table {module, band, rx, physId, primId, appId, value}
---@return boolean result # result
function LuaSPortSensor:pushFrame(frame) end

---Send a parameter request to the S.Port Sensor.
---Since: 1.1.0
---@param parameter integer
---@return boolean result # result
function LuaSPortSensor:requestParameter(parameter) end

---Get / set the rx index.
---Since: 1.1.0
---@param rx? integer
---@return integer rx # rx
function LuaSPortSensor:rx(rx) end

---Write a parameter to the S.Port Sensor.
---Since: 1.1.0
---@param parameter integer
---@param value integer
---@return boolean result # result
function LuaSPortSensor:writeParameter(parameter, value) end

---@class LuaSPortSerial
local LuaSPortSerial = {}

---Return true if the read buffer is empty.
---Since: 1.1.0
---@return boolean empty # empty
function LuaSPortSerial:empty() end

---Flush a buffer.
---Since: 1.1.0
function LuaSPortSerial:flush() end

---Return the read buffer.
---Since: 1.1.0
---@return string buffer # buffer
function LuaSPortSerial:read() end

---Return the read buffer size.
---Since: 1.1.0
---@return integer size # size
function LuaSPortSerial:size() end

---Write a buffer.
---Since: 1.1.0
function LuaSPortSerial:write() end

---@class Module
local Module = {}

---Get the state of the module.
---Since: 1.5.0
---@return boolean enable # enable
function Module:enable() end

---Mute all "Sensor lost" warnings from a module during a certain duration.
---Since: 1.6.0
---@param duration any # in s (number)
function Module:muteSensorLost(duration) end

---Get / Set one module option.
---Since: 1.6.0
---@param name? string # , value (integer, optional)
---@return integer value # value
function Module:option(name) end

---Get the state of all module options.
---Since: 1.6.0
---@return table options # options
function Module:options() end

---Get the protocol of the module.
---Since: 1.6.2
---@return integer protocol # protocol
function Module:protocol() end

---Get the type of the module.
---Since: 1.5.0
---@return integer type # type
function Module:type() end

---@class MultimoduleSensor
local MultimoduleSensor = {}

---Pop a Multimodule frame.
---Since: 1.6.0
---@return nil|any result # table
function MultimoduleSensor:popFrame() end

---Push a Multimodule frame.
---Since: 1.6.0
---@param data table
---@return boolean result # result
function MultimoduleSensor:pushFrame(data) end

---@class NumberEditLib
local NumberEditLib = {}

---Get / set the field decimals.
---Since: 1.1.0
---@param value? integer
---@return integer value # value
function NumberEditLib:decimals(value) end

---Set the field default value.
---Since: 1.1.0
---@param default integer
function NumberEditLib:default(default) end

---Enable / disable the instant change (the value is only updated when the field losts the focus)
---Since: 1.1.0
---@param enabled boolean
function NumberEditLib:enableInstantChange(enabled) end

---Set the field help text.
---Since: 1.5.10
---@param text string
function NumberEditLib:help(text) end

---Get / set the field maximum value.
---Since: 1.6.2
---@param value? integer
---@return integer value # value
function NumberEditLib:maximum(value) end

---Get / set the field minimum value.
---Since: 1.6.2
---@param value? integer
---@return integer value # value
function NumberEditLib:minimum(value) end

---Function called when the focus is changed.
---Since: 1.5.14
---@param handler any # function(state)
function NumberEditLib:onFocus(handler) end

---Set the field prefix.
---Since: 1.1.0
---@param prefix string
function NumberEditLib:prefix(prefix) end

---Get / set the field step.
---Since: 1.1.0
---@param value? integer
---@return integer value # value
function NumberEditLib:step(value) end

---Set the field suffix.
---Since: 1.1.0
---@param suffix string
function NumberEditLib:suffix(suffix) end

---Set the NumberEdit text handler.
---Since: 1.5.10
---@param handler fun(...):any # the function which will return the display string based on the value
function NumberEditLib:text(handler) end

---@class ProgressDialog
local ProgressDialog = {}

---Set the dialog message.
---@param message string
function ProgressDialog:message(message) end

---Set the progress value.
---@param value number
function ProgressDialog:value(value) end

---Allow or disallow user-initiated close.
---@param allowed boolean
function ProgressDialog:closedAllowed(allowed) end

---Close the progress dialog.
function ProgressDialog:close() end

---@class SliderLib: FormFieldLib
local SliderLib = {}

---Set the field help text.
---Since: 1.6.2
---@param text string
function SliderLib:help(text) end

---Set the field maximum value.
---Since: 1.6.2
---@param maximum integer
function SliderLib:maximum(maximum) end

---Set the field minimum value.
---Since: 1.6.2
---@param minimum integer
function SliderLib:minimum(minimum) end

---Function called when the focus is changed.
---Since: 1.6.2
---@param handler any # function(state)
function SliderLib:onFocus(handler) end

---Get / set the field step.
---Since: 1.6.2
---@param value number
---@return number value # value
function SliderLib:step(value) end

---@class Source
local Source = {}

---Get the last value age (only for Telemetry sources)
---Since: 1.6.2
---@return integer value_age_in_milliseconds # value age in milliseconds
function Source:age() end

---Get or set the appId of the source if is a FrSky sensor.
---Since: 1.5.5 source = system.getSource({ name = "GPS" }) source: appId (0x0110) print(source: name ().. " module:".. source: module ().. " band:".. source: band ().. " appId:".. source: appId ().. " physId:".. source: physId ()) Source::appId appId() Get or set the appId of the source if is a FrSky sensor. Definition: api_source.cpp:786 Source::physId physId() Get or set the physId of the source if it is a FrSky sensor. Definition: api_source.cpp:814 Source::band band() Get or set the band of the source if it is a FrSky Sensor. Definition: api_source.cpp:755 Source::module module() Get or set the module of the source if its category is TELEMETRY and it is not a Calculated Sensor. Definition: api_source.cpp:724 Source::name name() Return the source name (and modify it on Vars and Sensors) Definition: api_source.cpp:71
---@param appId? integer
---@return integer appId # appId
function Source:appId(appId) end

---Get or set the band of the source if it is a FrSky Sensor.
---Since: 1.5.5 source = system.getSource({ name = "GPS" }) source: band (0) print(source: name ().. " module:".. source: module ().. " band:".. source: band ().. " appId:".. source: appId ().. " physId:".. source: physId ())
---@param band? integer
---@return integer band # band
function Source:band(band) end

---Return the source category.
---Since: 1.1.2
---@return integer category # category
function Source:category() end

---Get or set the crsfId of the source if it is a CRSF sensor.
---Since: 1.6.2 source = system.getSource({ name = "Tx SNR" }) source: crsfId (0x0110) print(source: name ().. " module:".. source: module ().. " crsfId:".. source: crsfId ()).. " subId:".. source: subId ()) Source::subId subId() Get or set the subId of the source if it is a CRSF or a FrSky sensor. Definition: api_source.cpp:869 Source::crsfId crsfId() Get or set the crsfId of the source if it is a CRSF sensor. Definition: api_source.cpp:842
---@param crsfId? integer
---@return integer crsfId # crsfId
function Source:crsfId(crsfId) end

---Return the source decimals (and modify it on Vars and Sensors)
---Since: 1.5.5
---@param decimals integer
---@return integer decimals # decimals
function Source:decimals(decimals) end

---Drop a telemetry sensor.
---Since: 1.5.10 source = system.getSource({ name = "GPS" }) source: drop () Source::drop drop() Drop a telemetry sensor. Definition: api_source.cpp:909
function Source:drop() end

---Return the source maximum (and modify it on Vars and Sensors)
---Since: 1.5.0
---@return number value # value
function Source:maximum() end

---Return the source member.
---Since: 1.1.2
---@return integer member # member
function Source:member() end

---Return the source minimum (and modify it on Vars and Sensors)
---Since: 1.5.0
---@return number value # value
function Source:minimum() end

---Get or set the module of the source if its category is TELEMETRY and it is not a Calculated Sensor.
---Since: 1.5.5 source = system.getSource({ name = "GPS" }) source: module (0) print(source: name ().. " module:".. source: module ().. " band:".. source: band ().. " appId:".. source: appId ().. " physId:".. source: physId ())
---@param module? integer
---@return integer module # module
function Source:module(module) end

---Return the source name (and modify it on Vars and Sensors)
---Since: 1.5.5
---@param name? string
---@return string name # name
function Source:name(name) end

---Return the source options.
---Since: 1.1.4
---@return integer options # options
function Source:options() end

---Get or set the physId of the source if it is a FrSky sensor.
---Since: 1.5.5 source = system.getSource({ name = "GPS" }) source: physId (0x01) print(source: name ().. " module:".. source: module ().. " band:".. source: band ().. " appId:".. source: appId ().. " physId:".. source: physId ())
---@param physId? integer
---@return integer physId # physId
function Source:physId(physId) end

---Get / Set sensor internal decimals.
---Since: 1.5.10
---@param decimals integer
---@return integer decimals # decimals
function Source:protocolDecimals(decimals) end

---Get / Set the sensor internal unit.
---Since: 1.5.10
---@param unit? integer
---@return integer unit # unit
function Source:protocolUnit(unit) end

---Return the source raw value.
---Since: 1.1.0
---@return integer raw_value # raw value
function Source:rawValue() end

---Reset the source (Flight / Timer / Telemetry)
---Since: 1.1.0
function Source:reset() end

---Return the source state.
---Since: 1.1.0
---@return boolean state # state
function Source:state() end

---Return the source unit.
---Since: 1.1.0
---@return integer unit # unit
function Source:stringUnit() end

---Return the source value as a string.
---Since: 1.1.0
---@param options? integer
---@return string value # value
function Source:stringValue(options) end

---Get or set the subId of the source if it is a CRSF or a FrSky sensor.
---Since: 1.6.2 source = system.getSource({ name = "Tx SNR" }) print(source: name ().. " module:".. source: module ().. " crsfId:".. source: crsfId ()).. " subId:".. source: subId ())
---@param crsfId? integer
---@return integer crsfId # crsfId
function Source:subId(crsfId) end

---Return the source unit (and modify it on Vars and Sensors)
---Since: 1.1.0
---@param unit? integer
---@return integer unit # unit
function Source:unit(unit) end

---Return the source value / Set the source value on Lua sources / Vars / Telemetry sensors.
---Since: 1.1.0
---@param options? integer
---@return nil|integer|number|string value # value
function Source:value(options) end

---@class Timer
local Timer = {}

---Get / set the alarm value of the timer.
---Since: 1.1.0
---@param alarm? integer
---@return integer alarm # alarm
function Timer:alarm(alarm) end

---Get / set the audio actions of the timer.
---Since: 1.5.0
---@param actions? table
---@return table audio_actions # audio actions
function Timer:audioActions(actions) end

---Get / set the counting source of the timer.
---Since: 26.1.0
---@param source? any
---@return Source source # source
function Timer:countingSource(source) end

---Get / set the timer direction (1 / -1)
---Since: 1.1.0
---@param direction? integer
---@return integer direction # direction
function Timer:direction(direction) end

---Get / set the timer name.
---Since: 1.1.0
---@param name? string
---@return string name # name
function Timer:name(name) end

---Get / set the timer persistent attribute.
---Since: 26.1.0
---@param persistent? boolean
---@return boolean persistent # persistent
function Timer:persistent(persistent) end

---Reset the timer.
---Since: 1.4.10
function Timer:reset() end

---Get / set the reset condition of the timer.
---Since: 1.1.0
---@param condition? any
---@return Source reset # reset
function Timer:resetCondition(condition) end

---Return the running state of the timer.
---Since: 1.5.0
---@return boolean running # running
function Timer:running() end

---Get / set the start value of the timer.
---Since: 1.1.0
---@param start? integer
---@return integer start # start
function Timer:start(start) end

---Get / set the start condition of the timer.
---Since: 1.1.0
---@param condition? any
---@return Source condition # condition
function Timer:startCondition(condition) end

---Get / set the stop condition of the timer.
---Since: 26.1.0
---@return Source none_or_condition # None or condition
function Timer:stopCondition() end

---Return the timer value as a string.
---Since: 1.5.8
---@return string value # value
function Timer:stringValue() end

---Get / set the timer value.
---Since: 1.1.0
---@return integer value # value
function Timer:value() end

---Get / set the voice used by the timer.
---Since: 26.1.0
---@param voice? integer
---@return integer voice # voice
function Timer:voice(voice) end

---@class WaitDialog
local WaitDialog = {}

---BLACK (deprecated)
---@type integer
BLACK = 0

---BLUE (deprecated)
---@type integer
BLUE = 0

---Always ON
---@type integer
CATEGORY_ALWAYS_ON = 0

---Analogs Category, see System / Hardware screen for details
---@type integer
CATEGORY_ANALOG = 0

---Channels Category, see Model / Outputs screen for details
---@type integer
CATEGORY_CHANNEL = 0

---Flight Values Category
---@type integer
CATEGORY_FLIGHT = 0

---Flight Values Category (deprecated)
---@type integer
CATEGORY_FLIGHT_VALUE = 0

---Function Switches Category
---@type integer
CATEGORY_FUNCTION_SWITCH = 0

---Gyro Category
---@type integer
CATEGORY_GYRO = 0

---Gyro Switches Category
---@type integer
CATEGORY_GYRO_SWITCH = 0

---Logic Switches Category, see Model / Logic Switches screen for details
---@type integer
CATEGORY_LOGIC_SWITCH = 0

---None
---@type integer
CATEGORY_NONE = 0

---System special Category
---@type integer
CATEGORY_SPECIAL = 0

---Switches Category, see System / Hardware screen for details
---@type integer
CATEGORY_SWITCH = 0

---Switches Positions Category
---@type integer
CATEGORY_SWITCH_POSITION = 0

---System Category
---@type integer
CATEGORY_SYSTEM = 0

---System events Category
---@type integer
CATEGORY_SYSTEM_EVENT = 0

---Telemetry sensors Category, see Model / Telemetry screen for details
---@type integer
CATEGORY_TELEMETRY_SENSOR = 0

---Timers Category, see Model / Timers screen for details
---@type integer
CATEGORY_TIMER = 0

---Trainer Channels Category, see Model / Trainer screen for details
---@type integer
CATEGORY_TRAINER = 0

---Trims Category, see Model / Trims screen for details
---@type integer
CATEGORY_TRIM = 0

---Trims Positions Category
---@type integer
CATEGORY_TRIM_POSITION = 0

---CENTERED Text alignment (deprecated)
---@type integer
CENTERED = 0

---BLACK
---@type integer
COLOR_BLACK = 0

---BLUE
---@type integer
COLOR_BLUE = 0

---CYAN
---@type integer
COLOR_CYAN = 0

---GREEN
---@type integer
COLOR_GREEN = 0

---MAGENTA
---@type integer
COLOR_MAGENTA = 0

---ORANGE
---@type integer
COLOR_ORANGE = 0

---RED
---@type integer
COLOR_RED = 0

---WHITE
---@type integer
COLOR_WHITE = 0

---YELLOW
---@type integer
COLOR_YELLOW = 0

---Countdown beeps
---@type integer
COUNTDOWN_BEEP = 0

---Countdown value
---@type integer
COUNTDOWN_VALUE = 0

---Current Flight Mode (deprecated)
---@type integer
CURRENT_FLIGHT_MODE = 0

---Custom curve
---@type integer
CURVE_TYPE_CUSTOM = 0

---Exponent curve
---@type integer
CURVE_TYPE_EXPO = 0

---Function curve
---@type integer
CURVE_TYPE_FUNCTION = 0

---CYAN (deprecated)
---@type integer
CYAN = 0

---DOTTED Pen (deprecated)
---@type integer
DOTTED = 0

---Close Event Category
---@type integer
EVT_CLOSE = 0

---Key Event Category
---@type integer
EVT_KEY = 0

---Open Event Category
---@type integer
EVT_OPEN = 0

---Shutdown Category
---@type integer
EVT_SHUTDOWN = 0

---Key Touch Category
---@type integer
EVT_TOUCH = 0

---Current Flight Mode
---@type integer
FLIGHT_CURRENT_MODE = 0

---L Font
---@type integer
FONT_L = 0

---L BOLD Font (not available on X18 and Horus)
---@type integer
FONT_L_BOLD = 0

---M Font
---@type integer
FONT_M = 0

---M BOLD Font
---@type integer
FONT_M_BOLD = 0

---M ITALIC Font
---@type integer
FONT_M_ITALIC = 0

---S Font
---@type integer
FONT_S = 0

---S BOLD Font (not available on X18 and Horus)
---@type integer
FONT_S_BOLD = 0

---XL Font
---@type integer
FONT_XL = 0

---XS Font
---@type integer
FONT_XS = 0

---XS BOLD Font (not available on X18 and Horus)
---@type integer
FONT_XS_BOLD = 0

---XXL Font
---@type integer
FONT_XXL = 0

---XXS Font
---@type integer
FONT_XXS = 0

---Function curve: |f|
---@type integer
FUNC_ABS = 0

---Function curve: f < 0
---@type integer
FUNC_NEGATIVE = 0

---Function curve: f > 0
---@type integer
FUNC_POSITIVE = 0

---GREEN (deprecated)
---@type integer
GREEN = 0

---Radio System Date & Time (deprecated)
---@type integer
INTERNAL_CLOCK = 0

---RTN key break event (deprecated)
---@type integer
KEY_EXIT_BREAK = 0

---RTN key first press event (deprecated)
---@type integer
KEY_EXIT_FIRST = 0

---RTN key long press event (deprecated)
---@type integer
KEY_EXIT_LONG = 0

---MDL key break event (deprecated)
---@type integer
KEY_MODEL_BREAK = 0

---MDL key first press event (deprecated)
---@type integer
KEY_MODEL_FIRST = 0

---MDL key long press event (deprecated)
---@type integer
KEY_MODEL_LONG = 0

---deprecated
---@type integer
KEY_PAGE_DOWN = 0

---deprecated
---@type integer
KEY_PAGE_UP = 0

---Rotary left key event
---@type integer
KEY_ROTARY_LEFT = 0

---Rotary right key event
---@type integer
KEY_ROTARY_RIGHT = 0

---SYS key break event (deprecated)
---@type integer
KEY_SYSTEM_BREAK = 0

---SYS key first press event (deprecated)
---@type integer
KEY_SYSTEM_FIRST = 0

---SYS key long press event (deprecated)
---@type integer
KEY_SYSTEM_LONG = 0

---LEFT Text alignment (deprecated)
---@type integer
LEFT = 0

---Logic switch function |Δ| > X
---@type integer
LOGIC_SWITCH_FUNCTION_ABS_DELTA_GT = 0

---Logic switch function |A| > X
---@type integer
LOGIC_SWITCH_FUNCTION_ABS_GT = 0

---Logic switch function |A| < X
---@type integer
LOGIC_SWITCH_FUNCTION_ABS_LT = 0

---Logic switch function AND
---@type integer
LOGIC_SWITCH_FUNCTION_AND = 0

---Logic switch function A ~ X
---@type integer
LOGIC_SWITCH_FUNCTION_AROUND = 0

---Logic switch function Δ > X
---@type integer
LOGIC_SWITCH_FUNCTION_DELTA_GT = 0

---Logic switch function Edge
---@type integer
LOGIC_SWITCH_FUNCTION_EDGE = 0

---Logic switch function A = X
---@type integer
LOGIC_SWITCH_FUNCTION_EQ = 0

---Logic switch function A > X
---@type integer
LOGIC_SWITCH_FUNCTION_GT = 0

---Logic switch function A < X
---@type integer
LOGIC_SWITCH_FUNCTION_LT = 0

---Logic switch function OR
---@type integer
LOGIC_SWITCH_FUNCTION_OR = 0

---Logic switch function Range
---@type integer
LOGIC_SWITCH_FUNCTION_RANGE = 0

---Logic switch function Sticky
---@type integer
LOGIC_SWITCH_FUNCTION_STICKY = 0

---Logic switch function Timer
---@type integer
LOGIC_SWITCH_FUNCTION_TIMER = 0

---Logic switch function XOR
---@type integer
LOGIC_SWITCH_FUNCTION_XOR = 0

---MAGENTA (deprecated)
---@type integer
MAGENTA = 0

---Radio Main Voltage (deprecated)
---@type integer
MAIN_VOLTAGE = 0

---FLVSS Cells Count (deprecated)
---@type integer
OPTION_CELL_COUNT = 0

---FLVSS Highest Cell
---@type integer
OPTION_CELL_HIGHEST = 0

---FLVSS Lowest Cell
---@type integer
OPTION_CELL_LOWEST = 0

---FLVSS Cells Count
---@type integer
OPTION_CELLS_COUNT = 0

---Channel output (instead of Mixer output)
---@type integer
OPTION_CHANNEL_OUTPUT = 0

---Channel PWM value
---@type integer
OPTION_CHANNEL_PWM = 0

---GPS Latitude
---@type integer
OPTION_LATITUDE = 0

---GPS Longitude
---@type integer
OPTION_LONGITUDE = 0

---Sensor Maximum Value
---@type integer
OPTION_SENSOR_MAX = 0

---Sensor Minimum Value
---@type integer
OPTION_SENSOR_MIN = 0

---ORANGE (deprecated)
---@type integer
ORANGE = 0

---DASHED Pen
---@type integer
PEN_DASHED = 0

---DOTTED Pen
---@type integer
PEN_DOTTED = 0

---SOLID Pen
---@type integer
PEN_SOLID = 0

---Play file
---@type integer
PLAY_FILE = 0

---Play value
---@type integer
PLAY_VALUE = 0

---RED (deprecated)
---@type integer
RED = 0

---RIGHT Text alignment (deprecated)
---@type integer
RIGHT = 0

---Rotary left key event (deprecated)
---@type integer
ROTARY_LEFT = 0

---Rotary right key event (deprecated)
---@type integer
ROTARY_RIGHT = 0

---System event RSSI Low (deprecated)
---@type integer
RSSI_LOW = 0

---Radio RTC Voltage (deprecated)
---@type integer
RTC_VOLTAGE = 0

---CRSF Sensor
---@type integer
SENSOR_TYPE_CRSF = 0

---DIY Sensor
---@type integer
SENSOR_TYPE_DIY = 0

---S.Port Sensor
---@type integer
SENSOR_TYPE_SPORT = 0

---SOLID Pen (deprecated)
---@type integer
SOLID = 0

---System event Flight Reset
---@type integer
SYSTEM_EVENT_FLIGHT_RESET = 0

---System event RSSI Low
---@type integer
SYSTEM_EVENT_RSSI_LOW = 0

---System event Telemetry Active
---@type integer
SYSTEM_EVENT_TELEMETRY_ACTIVE = 0

---System event Throttle Active
---@type integer
SYSTEM_EVENT_THROTTLE_ACTIVE = 0

---System event Throttle Cut
---@type integer
SYSTEM_EVENT_THROTTLE_CUT = 0

---System event Throttle stick inside dead band
---@type integer
SYSTEM_EVENT_THROTTLE_DEAD_BAND = 0

---System event Throttle Hold
---@type integer
SYSTEM_EVENT_THROTTLE_HOLD = 0

---System event Trainer Active
---@type integer
SYSTEM_EVENT_TRAINER_ACTIVE = 0

---System event Trip Reset (= Flight Reset)
---@type integer
SYSTEM_EVENT_TRIP_RESET = 0

---Radio System Date & Time
---@type integer
SYSTEM_INTERNAL_CLOCK = 0

---Radio Main Voltage
---@type integer
SYSTEM_MAIN_VOLTAGE = 0

---Radio RAM available
---@type integer
SYSTEM_RAM_AVAILABLE = 0

---Radio RTC Voltage
---@type integer
SYSTEM_RTC_VOLTAGE = 0

---Radio Runtime
---@type integer
SYSTEM_RUNTIME = 0

---System event Telemetry Active (deprecated)
---@type integer
TELEMETRY_ACTIVE = 0

---CENTERED Text alignment
---@type integer
TEXT_CENTERED = 0

---LEFT Text alignment
---@type integer
TEXT_LEFT = 0

---RIGHT Text alignment
---@type integer
TEXT_RIGHT = 0

---THEME_DEFAULT_BGCOLOR
---@type integer
THEME_DEFAULT_BGCOLOR = 0

---THEME_DEFAULT_COLOR
---@type integer
THEME_DEFAULT_COLOR = 0

---THEME_FOCUS_BGCOLOR
---@type integer
THEME_FOCUS_BGCOLOR = 0

---THEME_FOCUS_COLOR
---@type integer
THEME_FOCUS_COLOR = 0

---THEME_WARNING_COLOR
---@type integer
THEME_WARNING_COLOR = 0

---System event Throttle Active (deprecated)
---@type integer
THROTTLE_ACTIVE = 0

---System event Throttle Cut (deprecated)
---@type integer
THROTTLE_CUT = 0

---System event Throttle Hold (deprecated)
---@type integer
THROTTLE_HOLD = 0

---System event Trainer Active (deprecated)
---@type integer
TRAINER_ACTIVE = 0

---Used in sport.getSensor() filters
---@type integer
UNDEFINED_VALUE = 0

---A
---@type integer
UNIT_AMPERE = 0

---Ah
---@type integer
UNIT_AMPERE_HOUR = 0

---bar
---@type integer
UNIT_BAR = 0

---°C
---@type integer
UNIT_CELSIUS = 0

---cm
---@type integer
UNIT_CENTIMETER = 0

---cm/s
---@type integer
UNIT_CENTIMETER_PER_SECOND = 0

---dB
---@type integer
UNIT_DB = 0

---dBm
---@type integer
UNIT_DBM = 0

---°
---@type integer
UNIT_DEGREE = 0

---°/s
---@type integer
UNIT_DEGREE_PER_SECOND = 0

---°F
---@type integer
UNIT_FAHRENHEIT = 0

---ft
---@type integer
UNIT_FOOT = 0

---ft/min
---@type integer
UNIT_FOOT_PER_MINUTE = 0

---ft/s
---@type integer
UNIT_FOOT_PER_SECOND = 0

---g
---@type integer
UNIT_G = 0

---g
---@type integer
UNIT_GRAM = 0

---Hz
---@type integer
UNIT_HERTZ = 0

---h
---@type integer
UNIT_HOUR = 0

---kg
---@type integer
UNIT_KILOGRAM = 0

---km
---@type integer
UNIT_KILOMETER = 0

---km/h
---@type integer
UNIT_KILOMETER_PER_HOUR = 0

---kt
---@type integer
UNIT_KILOTON = 0

---knots
---@type integer
UNIT_KNOT = 0

---kPa
---@type integer
UNIT_KPA = 0

---MHz
---@type integer
UNIT_MEGAHERTZ = 0

---m
---@type integer
UNIT_METER = 0

---m/min
---@type integer
UNIT_METER_PER_MINUTE = 0

---m/s
---@type integer
UNIT_METER_PER_SECOND = 0

---us
---@type integer
UNIT_MICROSECOND = 0

---mi
---@type integer
UNIT_MILE = 0

---m/h
---@type integer
UNIT_MILE_PER_HOUR = 0

---mA
---@type integer
UNIT_MILLIAMPERE = 0

---mAh
---@type integer
UNIT_MILLIAMPERE_HOUR = 0

---mg
---@type integer
UNIT_MILLIGRAM = 0

---ml
---@type integer
UNIT_MILLILITER = 0

---ml/min
---@type integer
UNIT_MILLILITER_PER_MINUTE = 0

---ml/pulse
---@type integer
UNIT_MILLILITER_PER_PULSE = 0

---ms
---@type integer
UNIT_MILLISECOND = 0

---mV
---@type integer
UNIT_MILLIVOLT = 0

---mW
---@type integer
UNIT_MILLIWATT = 0

---min
---@type integer
UNIT_MINUTE = 0

---MPa
---@type integer
UNIT_MPA = 0

---NM
---@type integer
UNIT_NAUTICAL_MILE = 0

---no unit
---@type integer
UNIT_NONE = 0

---Pa
---@type integer
UNIT_PA = 0

---%
---@type integer
UNIT_PERCENT = 0

---psi
---@type integer
UNIT_PSI = 0

---rad
---@type integer
UNIT_RADIAN = 0

---r/min
---@type integer
UNIT_RPM = 0

---s
---@type integer
UNIT_SECOND = 0

---t
---@type integer
UNIT_TON = 0

---V
---@type integer
UNIT_VOLT = 0

---W
---@type integer
UNIT_WATT = 0

---WHITE (deprecated)
---@type integer
WHITE = 0

---Function curve: |x|
---@type integer
X_ABS = 0

---Function curve: x < 0
---@type integer
X_NEGATIVE = 0

---Function curve: x > 0
---@type integer
X_POSITIVE = 0

---YELLOW (deprecated)
---@type integer
YELLOW = 0

---STD Font
---@type integer
FONT_STD = 0

---STD Bold Font
---@type integer
FONT_BOLD = 0

---Touch Move
---@type integer
TOUCH_MOVE = 0

---Touch Start
---@type integer
TOUCH_START = 0

---Touch End
---@type integer
TOUCH_END = 0

---@class bluetooth
bluetooth = {}

---List the characteristics of the main service.
---Since: 26.1.0
---@param services table
function bluetooth.listCharacteristics(services) end

---List the services.
---Since: 26.1.0
---@param services table
function bluetooth.listServices(services) end

---Write a characteristic value.
---Since: 26.1.0
---@param handle integer
---@param value integer|string
function bluetooth.write(handle, value) end

---@class crsf
crsf = {}

---Return a sensor.
---Since: 1.6.0
---@return CrsfSensor sensor # sensor
function crsf.getSensor() end

---@class form
form = {}

---Add a bitmap field to the current form.
---Since: 1.2.11
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param path string # the bitmaps directory
---@param getValue fun(...):any # the function which will return the current bitmap name
---@param setValue fun(...):any # the function which will be called on bitmap change
---@return FormFieldLib result # The new field
function form.addBitmapField(line, rect, path, getValue, setValue) end

---Add a boolean field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@return FormFieldLib result # The new field
function form.addBooleanField(line, rect, getValue, setValue) end

---Add a button to the current form.
---Since: 1.5.10
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param params table # table with elements: text (string, optional), icon (Mask, optional), press (function)
---@return LuaButton result # The new button
function form.addButton(line, rect, params) end

---Add a choice field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param values table # table of all possible values
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@return ChoiceLib result # The new field
function form.addChoiceField(line, rect, values, getValue, setValue) end

---Add a color field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current color
---@param setValue fun(...):any # the function which will be called on color change
---@return FormFieldLib result # The new field
function form.addColorField(line, rect, getValue, setValue) end

---Add an Expansion Panel to the current form.
---Since: 1.4.0
---@param text string # the displayed text
---@return ExpansionPanel result # The new field
function form.addExpansionPanel(text) end

---Add a file field to the current form.
---Since: 1.5.5
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param path string # the files directory
---@param fileType string # the files type: "txt" for text files, support.txt, "image" for image files, support.png,.jpg,.bmp, "lua" for lua script files, support.lua,.luac, "frk" for frk files, support.frk, "frsk" for frsk files, support.frsk, "bin" for binary files, support.bin, "audio" for audio files, support.wav, "video" for video files, support.mp4, "hex" for hex files, support.hex, "i18n" for translation files, support.i18n, "csv" for log files, support.csv, "md" for markdown files, support.md, followed by "+ext" to see the files with their extension
---@param getValue fun(...):any # the function which will return the current file name
---@param setValue fun(...):any # the function which will be called on file change
---@return FormFieldLib result # The new field
function form.addFileField(line, rect, path, fileType, getValue, setValue) end

---Add a function switch widget.
---Since: 1.6.3
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@param index number # the function switch index
---@return FormFieldLib result # The new field
function form.addFunctionSwitch(line, rect, index) end

---Add a new line to the current form.
---Since: 1.1.0
---@param label string # the line label
---@param panel? ExpansionPanel|nil # an expansion panel where the line should be inserted
---@param separator? boolean # separator after the line
---@return FormLine line # line
function form.addLine(label, panel, separator) end

---Add a number field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param min integer # the min value
---@param max integer # the max value
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@return NumberEditLib result # The new field
function form.addNumberField(line, rect, min, max, getValue, setValue) end

---Add a pot widget.
---Since: 1.6.3
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@param index number # the pot index
---@param type string # pot type, can take the values "pot" (default), "slider", "left" or "right"
---@return FormFieldLib result # The new field
function form.addPot(line, rect, index, type) end

---Add the radio hardware widget (sticks / pots / sliders / switches)
---Since: 1.6.3
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@return FormFieldLib result # The new field
function form.addRadioHardware(line, rect) end

---Add a rotary encoder widget.
---Since: 26.1.0
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@return FormFieldLib result # The new field
function form.addRotaryEncoder(line, rect) end

---Add a sensor field to the current form.
---Since: 1.5.4
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@param filterValue? fun(...):any # the function which will filter values
---@return FormFieldLib result # The new field
function form.addSensorField(line, rect, getValue, setValue, filterValue) end

---Add a slider field to the current form.
---Since: 1.5.2
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param min integer # the min value
---@param max integer # the max value
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@return SliderLib result # The new field
function form.addSliderField(line, rect, min, max, getValue, setValue) end

---Add a source field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@return FormFieldLib result # The new field
function form.addSourceField(line, rect, getValue, setValue) end

---Add a static text to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the text should be added
---@param rect? Rect|nil # the coordinates
---@param text string # the displayed text
---@return FrSkyStaticTextLib result # The new field
function form.addStaticText(line, rect, text) end

---Add a stick widget.
---Since: 1.6.3
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@param xIndex number # the horizontal analog index
---@param yIndex number # the vertical analog index
---@return FormFieldLib result # The new field
function form.addStick(line, rect, xIndex, yIndex) end

---Add a switch widget.
---Since: 1.6.3
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@param index number # the switch index
---@param type string # switch type, can take the values "lever" (default) or "push"
---@return FormFieldLib result # The new field
function form.addSwitch(line, rect, index, type) end

---Add a switch field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current value
---@param setValue fun(...):any # the function which will be called on value change
---@return FormFieldLib result # The new field
function form.addSwitchField(line, rect, getValue, setValue) end

---Add a text button to the current form (deprecated)
---Since: 1.1.0
---@deprecated
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param text string # the displayed text
---@param press fun(...):any # the function which will be called on button press
---@return LuaButton result # The new button
function form.addTextButton(line, rect, text, press) end

---Add a text field to the current form.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current text
---@param setValue fun(...):any # the function which will be called on text change
---@return FormFieldLib result # The new field
function form.addTextField(line, rect, getValue, setValue) end

---Add a time field to the current form.
---Since: 26.1.0
---@param line FormLine # the line where the field should be added
---@param rect? Rect|nil # the coordinates
---@param getValue fun(...):any # the function which will return the current time
---@param setValue fun(...):any # the function which will be called on time change
---@return FormFieldLib result # The new field
function form.addTimeField(line, rect, getValue, setValue) end

---Add a trim widget.
---Since: 1.6.3
---@param line? FormLine|nil # the line where the widget should be added
---@param rect? Rect|nil # the coordinates
---@param index number # the trim index
---@param type string # trim type, can take the values "horizontal" (default) or "vertical"
---@return FormFieldLib result # The new field
function form.addTrim(line, rect, index, type) end

---Clear the current form.
---Since: 1.1.0
function form.clear() end

---Create a form (deprecated)
---@deprecated
function form.create() end

---Return a table of coordinates for fields in a line.
---Since: 1.1.0
---@param line FormLine # the line where the field should be added
---@param fields nil|table # table of specs for each field in the line (either a string, or a width). The available space will be splitted into all cells where specs have a zero-width
---@return table rects # rects
function form.getFieldSlots(line, fields) end

---Get the height of the current form.
---Since: 1.5.7
function form.height() end

---Invalidate the current form (deprecated)
---@deprecated
function form.invalidate() end

---Open a dialog.
---Since: 1.1.0
---@param params table # table with elements: title, message, buttons, options, wakeup, paint, closeWhenClickOutside
---@return Dialog result # Dialog
function form.openDialog(params) end

---Open a wait dialog.
---Since: 1.5.10
---@param params table # table with elements: title, message, progress, wakeup, close
---@return WaitDialog result # WaitDialog
function form.openWaitDialog(params) end

---Open a progress dialog.
---@param title string # dialog title
---@param message string # dialog message
---@param wakeup fun(...):any # wakeup callback
---@param close fun(...):any # close callback
---@return ProgressDialog result # ProgressDialog
function form.openProgressDialog(title, message, wakeup, close) end

---@class glasses
glasses = {}

---Draw a bitmap at position x, y.
---Since: 26.1.0
---@param x integer # bitmap horizontal position
---@param y integer # bitmap vertical position
---@param bitmap integer # bitmap ID
function glasses.bitmap(x, y, bitmap) end

---Create a layout.
---Since: 26.1.0
---@param params any # table with elements: x (integer): left y (integer): top w (integer): width h (integer): height text : table with elements: x (integer): text left y (integer): text top opacity (integer): text opacity font (integer): text font bitmap : table with elements: id (unsigned): bitmap ID x (integer): bitmap left y (integer): bitmap top border (boolean): layout border
---@return GlassesLayout result # the new layout
function glasses.createLayout(params) end

---Get the window size.
---Since: 26.1.0
---@return integer width # width
---@return integer height # height
function glasses.getWindowSize() end

---Write text at position x, y.
---Since: 26.1.0
---@param x integer # text horizontal position
---@param y integer # text vertical position
---@param font integer # text font ID
---@param text string # text
function glasses.text(x, y, font, text) end

---@class lcd
lcd = {}

---Get / set the current color.
---Since: 1.1.0
---@param color? integer # color value
---@return integer color # color
function lcd.color(color) end

---Return true if the dark mode is enable.
---Since: 1.5.3
---@return boolean darkMode # darkMode
function lcd.darkMode() end

---Draw a circular sector.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param intR number # the inner circle radius, if it is equal to 0, a fan-shaped can be drawn
---@param extR number # the external circle radius
---@param startAngle number # starting angle of the circular sector
---@param endAngle number # ending angle of the circular sector
function lcd.drawAnnulusSector(x, y, intR, extR, startAngle, endAngle) end

---Draw a bitmap.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param bitmap Bitmap # bitmap
---@param w? number # the width of the bitmap displayed
---@param h? number # the height of the bitmap display
function lcd.drawBitmap(x, y, bitmap, w, h) end

---Draw a circle.
---Since: 1.1.0
---@param x number # X coordinate of the center of the circle
---@param y number # Y coordinate of the center of the circle
---@param r number # circle radius
function lcd.drawCircle(x, y, r) end

---Draw a filled circle.
---Since: 1.1.0
---@param x number # X coordinate of the center of the circle
---@param y number # Y coordinate of the center of the circle
---@param r number # circle radius
function lcd.drawFilledCircle(x, y, r) end

---Draw a filled rectangle.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param w number # rectangle width
---@param h number # rectangle height
function lcd.drawFilledRectangle(x, y, w, h) end

---Draw a filled triangle.
---Since: 1.5.5
---@param x1 number # X1 coordinate
---@param y1 number # Y1 coordinate
---@param x2 number # X2 coordinate
---@param y2 number # Y2 coordinate
---@param x3 number # X3 coordinate
---@param y3 number # Y3 coordinate
function lcd.drawFilledTriangle(x1, y1, x2, y2, x3, y3) end

---Draw a line.
---Since: 1.1.0
---@param x1 number # X coordinate of the start point
---@param y1 number # Y coordinate of the start point
---@param x2 number # X coordinate of the end point
---@param y2 number # Y coordinate of the end point
function lcd.drawLine(x1, y1, x2, y2) end

---Draw a mask.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param mask Mask # mask
function lcd.drawMask(x, y, mask) end

---Draw a number with units.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param value number # displayed value
---@param unit? integer # unit
---@param decimals? integer # number of decimals
---@param flags? integer # flags (LEFT / RIGHT / CENTERED)
function lcd.drawNumber(x, y, value, unit, decimals, flags) end

---Draw a point at given coordinates.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
function lcd.drawPoint(x, y) end

---Draw a rectangle.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param w number # rectangle width
---@param h number # rectangle height
---@param thickness? integer # the thickness of the rectangle frame
function lcd.drawRectangle(x, y, w, h, thickness) end

---Draw a text.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param text string # displayed text
---@param flags? integer # flags (LEFT / RIGHT / CENTERED)
function lcd.drawText(x, y, text, flags) end

---Draw a triangle.
---Since: 1.5.5
---@param x1 number # X1 coordinate
---@param y1 number # Y1 coordinate
---@param x2 number # X2 coordinate
---@param y2 number # Y2 coordinate
---@param x3 number # X3 coordinate
---@param y3 number # Y3 coordinate
function lcd.drawTriangle(x1, y1, x2, y2, x3, y3) end

---Get / set the current font.
---Since: 1.1.0
---@param font integer # one of the available fonts (FONT_M, FONT_BOLD, FONT_ITALIC, FONT_XS, FONT_XS_BOLD, FONT_S, FONT_L, FONT_L_BOLD, FONT_XL, FONT_XXL)
---@return integer font # font
function lcd.font(font) end

---Get the dimensions that will be taken up with text when using the current parameters.
---Since: 1.1.0
---@param text string
---@return integer width # width
---@return integer height # height
function lcd.getTextSize(text) end

---Get the window size.
---Since: 1.1.0
---@return integer width # width
---@return integer height # height
function lcd.getWindowSize() end

---Get a grey color from a dark value (0 = darker) with optional alpha opacity.
---Since: 1.1.0
---@param value integer # dark value(0 - 255)
---@param alpha? number # alpha value(0 - 1.0)
---@return integer color # color
function lcd.GREY(value, alpha) end

---Return true if the current window has the focus, else false.
---Since: 1.5.0
---@return boolean focus # focus
function lcd.hasFocus() end

---Invalidate the window or a part of the window (it will be fully drawn on next LCD refresh)
---Since: 1.1.0
---@param x? number # X coordinate
---@param y? number # Y coordinate
---@param w? number # rectangle width
---@param h? number # rectangle height
function lcd.invalidate(x, y, w, h) end

---Check if the window is visible on screen or not.
---Since: 1.5.0
---@return boolean visible # visible
function lcd.isVisible() end

---Load a bitmap from a file. Allowed formats are BMP / JPG / PNG. Transparency is supported, but it will use more resources.
---Since: 1.1.0
---@param path string # bitmap path
---@param lazy? boolean # lazy load (only loaded when needed)
---@return Bitmap bitmapHandle # bitmapHandle
function lcd.loadBitmap(path, lazy) end

---Load a font from file.
---Since: 1.1.0
---@param path string # font path
---@return integer font_index # font index
function lcd.loadFont(path) end

---Load a mask from a file. Allowed formats are BMP / JPG / PNG, 8-bit/color, RGB.
---Since: 1.1.0
---@param path string # mask path
---@param lazy? boolean # lazy load (only loaded when needed)
---@return Mask maskHandle # maskHandle
function lcd.loadMask(path, lazy) end

---Get / set the current pen style.
---Since: 1.1.0
---@param pen integer # a binary mask or one of the values SOLID, DOTTED or DASHED
---@return integer pen # pen
function lcd.pen(pen) end

---Reset the 10s focus timeout on Home screen.
---Since: 1.5.1
function lcd.resetFocusTimeout() end

---Get a color from red, green and blue values with optional alpha opacity.
---Since: 1.1.0
---@param red integer # red value(0 - 255)
---@param green integer # green value(0 - 255)
---@param blue integer # blue value(0 - 255)
---@param alpha? number # alpha value(0 - 1.0)
---@return integer color # color
function lcd.RGB(red, green, blue, alpha) end

---Set the clipping rect.
---Since: 1.1.0
---@param x number # X coordinate
---@param y number # Y coordinate
---@param w number # rectangle width
---@param h number # rectangle height
---@return integer width # width
---@return integer height # height
function lcd.setClipping(x, y, w, h) end

---Set the window title.
---Since: 1.4.6
---@param text string # title
---@param color? number # title color
function lcd.setWindowTitle(text, color) end

---Get / set the theme color.
---Since: 1.1.0
---@param index integer # theme color index
---@param color? integer # color value
---@return integer color # color
function lcd.themeColor(index, color) end

---@class model
model = {}

---Get / set the model bitmap.
---Since: 1.1.0
---@param bitmap? string
---@return string bitmap # bitmap
function model.bitmap(bitmap) end

---Create a curve.
---Since: 1.1.0
---@return Curve result # the new curve
function model.createCurve() end

---Create a logic switch.
---Since: 26.1.0
---@return LogicSwitch result # the new logic switch
function model.createLogicSwitch() end

---Create a mix.
---Since: 1.6.0
function model.createMix() end

---Create a sensor.
---Since: 1.5.5
---@return Source result # the source of the created sensor
function model.createSensor() end

---Create a timer.
---Since: 1.1.0
---@return Timer result # the new timer
function model.createTimer() end

---Mark the model as dirty.
---Since: 1.1.2
function model.dirty() end

---Return output channel information.
---Since: 1.6.0
---@param Name string
---@param Index integer
---@return Channel result # channel
function model.getChannel(Name, Index) end

---Return a curve by name or by index.
---Since: 1.1.0
---@param Name string
---@param Index integer
---@return Curve result # curve
function model.getCurve(Name, Index) end

---Return a logic switch by name or by index.
---Since: 26.1.0
---@param Name string
---@param Index integer
---@return LogicSwitch result # logic switch
function model.getLogicSwitch(Name, Index) end

---Return module information.
---Since: 1.5.0
---@param Index integer
---@return Module result # module
function model.getModule(Index) end

---Return a timer by name or by index.
---Since: 1.1.0
---@param Name string
---@param Index integer
---@return Timer result # timer
function model.getTimer(Name, Index) end

---Get the model ids (internal and external modules)
---Since: 1.3.2
---@return table ids # ids
function model.id() end

---Get / set the model name.
---Since: 1.1.0
---@param name? string
---@return string name # name
function model.name(name) end

---Get the model relative path.
---Since: 1.5.5
---@return string name # name
function model.path() end

---Reset Flight data.
---Since: 1.4.10
---@param context string
function model.resetFlight(context) end

---@class multimodule
multimodule = {}

---Return a sensor.
---Since: 1.6.0
---@return MultimoduleSensor sensor # sensor
function multimodule.getSensor() end

---@class serial
serial = {}

---Open a serial connection (only on TANDEM radios)
---Since: 1.1.0
---@param name string
---@param baudrate? any
---@param mode? string
---@param power? boolean
---@return LuaSPortSerial result # the new serial connection
function serial.open(name, baudrate, mode, power) end

---@class simulator
simulator = {}

---Simulate Bluetooth advertize.
---Since: 26.1.0
---@param device string
function simulator.advertizeBluetooth(device) end

---Simulate USB connect / disconnect.
---Since: 1.5.0
---@param state boolean
function simulator.connectUsb(state) end

---Enter text.
---Since: 26.1.0
---@param text string
function simulator.enterText(text) end

---Simulate S.Port telemetry.
---Since: 26.1.0
---@param frame table
function simulator.injectSPortFrame(frame) end

---Load a model.
---Since: 1.5.0
---@param path string
function simulator.loadModel(path) end

---Simulate a function switch press.
---Since: 26.1.0
---@param index integer
---@param duration? any # in seconds (number, optional)
function simulator.pressFunctionSwitch(index, duration) end

---Simulate a key press.
---Since: 1.5.0
---@param key integer
---@param duration? any # in seconds (number, optional)
function simulator.pressKey(key, duration) end

---Reload the Lua scripts.
---Since: 26.1.0
function simulator.reloadScripts() end

---Reset the analogs positions.
---Since: 26.1.0
function simulator.resetAnalogs() end

---Reset the backlight timer.
---Since: 26.1.0
function simulator.resetBacklightTimer() end

---Reset the inactivity timer.
---Since: 26.1.0
function simulator.resetInactivityTimer() end

---Reset the switchs positions.
---Since: 26.1.0
function simulator.resetSwitches() end

---Take a screenshot.
---Since: 1.5.0
---@param path string
function simulator.screenshot(path) end

---Set an analog position.
---Since: 1.5.0
---@param analog integer
---@param value integer
function simulator.setAnalog(analog, value) end

---Set the date & time.
---Since: 1.5.0
---@param table any # { sec, min, hour, day, month, year, lock }
function simulator.setDateTime(table) end

---Load a model.
---Since: 1.5.0
---@param path string
function simulator.setReadOnly(path) end

---Set a switch position.
---Since: 1.5.0
---@param swtch integer
---@param position integer
function simulator.setSwitch(swtch, position) end

---Sleep.
---Since: 1.5.0
---@param duration any # in seconds (number)
function simulator.sleep(duration) end

---Simulate a touch event.
---Since: 1.5.0
---@param x integer
---@param y integer
function simulator.touch(x, y) end

---Simulate the rotary encoder.
---Since: 1.5.0
---@param steps integer
function simulator.turnRotaryEncoder(steps) end

---@class sport
sport = {}

---Return a sensor.
---Since: 1.1.0
---@param appId integer # or table {module, band, rx, physId, appId}
---@return LuaSPortSensor sensor # sensor
function sport.getSensor(appId) end

---@class storage
storage = {}

---Read a value from the current storage.
---Since: 1.1.0
---@param label string
---@return any result # The value read
function storage.read(label) end

---Write a value to the current storage.
---Since: 1.1.0
---@param label string
---@param value any # the value to write
function storage.write(label, value) end

---@class system
system = {}

---Compile the lua script into luac.
---Since: 1.5.3
---@param path string # lua source file
---@param strip? boolean # strip debug infor from the compiled file
function system.compile(path, strip) end

---Launch the Emergency Mode (EM) - for testing purposes only.
---Since: 1.5.8
function system.emergency() end

---Exit the current script.
---Since: 1.1.0
function system.exit() end

---Return the current audio voice.
---Since: 1.5.7
---@return string result # Audio voice as a string, i.e. "en/default"
function system.getAudioVoice() end

---Get the result of the Latency test - for testing purposes only.
---Since: 26.1.0
---@return nil|number result # delay between request and response
function system.getLatencyTestResult() end

---Return the current locale.
---Since: 1.1.0
---@return string result # Locale as a string, i.e. "en", "fr"
function system.getLocale() end

---Return Ethos Memory Usage.
---Since: 1.1.0
---@return SystemGetMemoryUsageResult result
function system.getMemoryUsage() end

---Return a Source.
---Since: 1.1.0
---@param name string|table # Source name or table {name, category, member, options}
---@return Source source # source
function system.getSource(name) end

---Return the list of sources within a category.
---Since: 26.1.0
---@param category number
---@return Source[] sources # sources
function system.getSources(category) end

---Return the stick mode.
---Since: 1.1.0
---@return integer stick_mode # Stick Mode
function system.getStickMode() end

---Return Ethos version.
---Since: 1.1.0
---@return SystemGetVersionResult result
function system.getVersion() end

---Return if the sensor discover is active.
---Since: 1.6.4
---@return boolean result # Boolean
function system.isSensorDiscoverActive() end

---Kill key events (i.e. after a LONG PRESS event, a KEY RELEASE event may be skipped)
---Since: 1.1.0
---@param event number
function system.killEvents(event) end

---List files in a directory.
---Since: 1.5.0
---@param directory string
---@return table files # files
function system.listFiles(directory) end

---Open a page.
---Since: 26.1.0
---@param page? table # with elements: system (integer or nil): system page index or nil for the menu page model (integer or nil): model page index or nil for the menu page home (integer, optional): home page index logicSwitch (integer, optional): logic switch page index timer (integer, optional): timer page index sensor (integer, optional): sensor page index
function system.openPage(page) end

---Play an audio file.
---Since: 1.1.0
---@param audio any # file path (string)
function system.playFile(audio) end

---Play haptic vibration.
---Since: 1.1.0
---@param ms number
---@param pattern string
---@param strength? number # % of the max strength, 0 stands for the strength entered in System
function system.playHaptic(ms, pattern, strength) end

---Play a number using the current locale.
---Since: 1.1.0
---@param value number
---@param unit? number
---@param decimals? number
---@param voice? number
---@param priority? number
function system.playNumber(value, unit, decimals, voice, priority) end

---Play a tone.
---Since: 1.1.0
---@param frequency any # in Hz (number)
---@param duration any # in ms (number)
---@param pause? any # in ms (number, optional)
function system.playTone(frequency, duration, pause) end

---Register the TBS Crossfire Module.
---Since: 1.3.1
function system.registerCrossfireModule() end

---Register the ELRS Module.
---Since: 1.3.1
function system.registerElrsModule() end

---Register the Ghost Module.
---Since: 1.3.0
function system.registerGhostModule() end

---Register a Lua Layout.
---Since: 1.5.8
---@param params? any # table with elements: key (string): unique key, with 7 chars max widgets (table of rect, optional): layout widgets slots trims (table of rect, optional): layout trims slots pots (table of rect, optional): layout pots slots
function system.registerLayout(params) end

---Register the mLRS Module.
---Since: 26.1.0
function system.registerMlrsModule() end

---Register a Multimodule Protocol.
---Since: 1.3.0
---@param label string # protocol name
---@param id any # protocol ID
---@param params? any # table with elements: variants (table, optional): protocol variants minChannels (unsigned, optional): minimum channels count maxChannels (unsigned, optional): maximum channels count features (unsigned, optional): protocol features options (table of options, optional): protocol options with elements: name (string): option name min (int): option min max (int): option max display (function, optional): display function for the option value
function system.registerMultimoduleProtocol(label, id, params) end

---Register a Lua Source.
---Since: 1.1.0
---@param params? any # table with elements: key (string, 7 chars max): source key name (string or function): source name init (function, optional): handler called on source init wakeup (function, optional): handler called at each loop read (function, optional): optional read handler write (function, optional): optional write handler configure (function, optional): handler called on source configuration
function system.registerSource(params) end

---Register a Lua System Tool.
---Since: 1.1.0
---@param params? any # table with elements: name (string or function): tool name icon (string): tool icon create (function, optional): handler called on widget creation, it will return the widget which is passed later to all functions wakeup (function, optional): handler called at each loop event (function, optional): handler called when an event is received (event not passed to the parent window if the handler returns True) paint (function, optional): paint function close (function, optional): handler called on page closed title (boolean, optional): title
---@return integer page_index # page index
function system.registerSystemTool(params) end

---Register a Lua Task.
---Since: 1.5.0
---@param params? any # table with elements: key (string, 7 chars max): task key name (string or function): task name init (function, optional): handler called on task init event (function, optional): handler called at each event wakeup (function, optional): handler called at each loop read (function, optional): optional read handler write (function, optional): optional write handler configure (function, optional): handler called on task configuration
function system.registerTask(params) end

---Register a Lua Widget.
---Since: 1.1.0
---@param params? any # table with elements: key (string): unique key, with 7 chars max name (string or function): widget name create (function, optional): handler called when the widget is added to the model (created / read from storage), it will return the widget which is passed later to all functions destroy (function, optional): handler called on widget deletion configure (function, optional): handler called on widget configuration build (function, optional): handler called when the widget is built in the Home screen, after creation and configuration wakeup (function, optional): handler called at each loop event (function, optional): handler called when an event is received (event not passed to the parent window if the handler returns True) paint (function): paint function menu (function, optional): handler called when the contextual menu is created, to allow adding more options to the menu, the handler should return a table of pairs { name, function } read (function, optional): optional read handler write (function, optional): optional write handler persistent (boolean, optional): persistent data title (boolean, optional): title forced ON / OFF
function system.registerWidget(params) end

---Reset the backlight timeout.
---Since: 1.1.0
function system.resetBacklightTimeout() end

---Launch the Latency test on one channel - for testing purposes only.
---Since: 26.1.0
---@param channel integer
---@param value number
---@param maxDuration number
function system.startLatencyTest(channel, value, maxDuration) end

---Return the Radio voltage range.
---Since: 1.5.16
---@return number min
---@return number max
function system.voltageRange() end

---Check if a file or directory exists and retrieve its info.
---@param path string
---@return table|nil result
function os.stat(path) end

---Remove a file or an empty directory.
---@param path string
---@return boolean result
function os.remove(path) end

---Rename a file or a directory.
---@param from string
---@param to string
---@return boolean result
function os.rename(from, to) end

---Remove a directory tree recursively.
---@param path string
---@return boolean result
function os.rmtree(path) end

---Create an empty directory.
---@param path string
---@return boolean result
function os.mkdir(path) end

---Copy a file or directory to another directory.
---@param source string
---@param destination string
---@return boolean result
function os.copy(source, destination) end
