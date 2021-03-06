---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by apple.
--- DateTime: 2018/10/14 上午12:51
---
--- @class MainStage : Stage
MainStage = Class("MainStage",Stage)

--- init
local style = {
    font = font32,
    showBorder = true,
    bgColor = {0.208, 0.220, 0.222,0.222},
    --group = "MainStage"
    --fgColor = {1,0,0}
}

require("lib.gooi")
function MainStage:init()
    self.area = Area(self)
    self.area:addPhysicsWorld()
    self.main_canvas = love.graphics.newCanvas(gw,gh)
    self.background = assets.graphics.Backgrounds.bg
    self.ui = gooi
    self.ui.desktopMode()
    self.ui_group = "MainStage"
    self.ui.setStyle(style)
    self.ui.newLabel({text = "武侠与江湖",x = gw/2 - 320,y=gh/6,w = 320,group = self.ui_group}):setStyle({font = font80}):fg({0,0,0}):center()
    self.panel = self.ui.newPanel({x = gw/2 - 80,y = gh/2,w = 160,h = 160,layout = "grid 4x1"})
    self.panel:add(self.ui.newButton({text = "新的穿越",group = self.ui_group}):setStyle({font = font32})
            :onRelease(
            function()
                gotoRoom("CreateStage","CreateStage")
                self.ui.setGroupVisible(self.ui_group,false)
                self.ui.setGroupEnabled(self.ui_group,false)
            end)
    )
    self.panel:add(self.ui.newButton({text = "梦回武林",group = self.ui_group}):setStyle({font = font32})
            :onRelease(
            function ()
                gotoRoom("LoadStage","LoadStage")
                self.ui.setGroupVisible(self.ui_group,false)
                self.ui.setGroupEnabled(self.ui_group,false)
            end)
    )
    self.panel:add(self.ui.newButton({text = "侠客宝典",group = self.ui_group}):setStyle({font = font32})
            :onRelease(
            function ()
                gotoRoom("SkillTreeStage","SkillTreeStage")
                self.ui.setGroupVisible(self.ui_group,false)
                self.ui.setGroupEnabled(self.ui_group,false)
            end)
    )

    self.panel:add(self.ui.newButton({group = self.ui_group,text = "归隐山林"}):setStyle({font = font32})
                       :onRelease(
            function()
                self.ui.confirm({group = self.ui_group,text = "梦醒",okText = "是",cancelText = "否",ok = function () love.event.quit() end})
            end
    ))
end

function MainStage:activate()
    self.ui.setGroupVisible(self.ui_group,true)
    self.ui.setGroupEnabled(self.ui_group,true)
end

function MainStage:deactivate()
    --upper_room = current_room
    self.ui.setGroupVisible(self.ui_group,false)
    self.ui.setGroupEnabled(self.ui_group,false)
end

function MainStage:update(dt)
    if self.area then self.area:update(dt) end
    self.ui.update(dt)
end

function MainStage:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    camera:attach(0,0,gw,gh)

    if self.area then self.area:draw() end
    camera:detach()
    love.graphics.setCanvas()
    love.graphics.draw(self.background)
    love.graphics.setColor(1,1,1,1)
    love.graphics.setBlendMode('alpha','premultiplied')
    love.graphics.draw(self.main_canvas,0,0,0,sx,sy)
    love.graphics.setBlendMode('alpha')
    self.ui.draw(self.ui_group)

end

function MainStage:mousereleased()
    self.ui.released()
end

function MainStage:mousepressed()
    self.ui.pressed()
end

function MainStage:destroy()
    if self.area then
        self.area:destroy()
        self.area = nil
    end
end

return MainStage