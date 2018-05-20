function Key_Down(src,event)
    disp('in kd')
    switch event.Character
        case 'y'
            setappdata(src, 'answer', event.Character)
            return
        case 'n'
            setappdata(src, 'answer', event.Character)
            return
    end
end
