--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
require "Demo/Fight/FightHeroFSM/FightHeroIdleState.lua"
require "Demo/Fight/FightHeroFSM/FightHeroMoveState.lua"
require "Demo/Fight/FightHeroFSM/FightHeroAttackState.lua"

FightHero = class("FightHero");

function FightHero:Awake()
    self.mNavMeshAgent = self.gameObj:GetComponent("NavMeshAgent");
    self.animation = self.gameObj:GetComponent("Animation");
    --状态机
    self.idleState = FightHeroIdleState:new(self);
    self.moveState = FightHeroMoveState:new(self);
    self.attackState = FightHeroAttackState:new(self);
    --设置当前状态
    self.curState = self.idleState;
    self.curState:OnEnter();
end

function FightHero:Update()
    self.curState:OnUpdate();
end

function FightHero:IsMoving()
    return (self.curState == self.moveState);
end

function FightHero:Translate(state, args)
    if not state then
        error("FightHero:Translate state is nil");
        return;
    end
    self.curState:OnExit();
    self.curState = state;
    self.curState:OnEnter(args);
end

function FightHero:HandleMsg(msg, ...)
    self.curState:HandleMsg(msg, ...);
end

--endregion
