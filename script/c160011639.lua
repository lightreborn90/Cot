-- Ultimate Trinity Stargazer (Rush Duel)
-- Assigned custom ID: 160011639
local s,id=GetID()
function s.initial_effect(c)
    -- Fusion Material Configuration
    c:EnableReviveLimit()
    Fusion.AddProcMix(c,true,true,160009002,160009019,160010101) -- Galactica Oblivion, Jointech Rex, Blue-Fang Burst Dragon
    
    -- Effect: Decrease ATK by 7500
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetCategory(CATEGORY_ATKCHANGE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(s.condition)
    e1:SetCost(s.cost)
    e1:SetTarget(s.target)
    e1:SetOperation(s.operation)
    c:RegisterEffect(e1)
end

function s.condition(e,tp,eg,ep,ev,re,r,rp)
    -- Standard Rush Duel Ignition Condition
    return true
end

function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1) end
    Duel.DiscardDeck(tp,1,REASON_COST)
end

function s.filter(c)
    return c:IsFaceup()
end

function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,0,LOCATION_MZONE,1,nil) end
end

function s.operation(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(s.filter,tp,0,LOCATION_MZONE,nil)
    if #g>0 then
        for tc in aux.Next(g) do
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetValue(-7500)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
            tc:RegisterEffect(e1)
        end
    end
end
