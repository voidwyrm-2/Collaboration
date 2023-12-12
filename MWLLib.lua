function Toggle(keyinput, key, bool) --keyinput: the key that's actually getting pressed, key: the key that's checked for, bool: the bool that's toggled; example: TheBool = Toggle(k, 'q', TheBool)
    if keyinput == key and not bool then
        return true
    elseif keyinput == key and bool then
        return false
    end
end