---------------------------------------------------------------------------
--  Super Punch-Out!!! Sound Library Script | Version 1.0 for BizHawk
--  
--  Author: VMMR (VictorMR)
---------------------------------------------------------------------------

--#############################################################################

local INPUT_KEYNAMES = {  -- BizHawk
    
    A=false, Add=false, Alt=false, Apps=false, Attn=false, B=false, Back=false, BrowserBack=false, BrowserFavorites=false,
    BrowserForward=false, BrowserHome=false, BrowserRefresh=false, BrowserSearch=false, BrowserStop=false, C=false,
    Cancel=false, Capital=false, CapsLock=false, Clear=false, Control=false, ControlKey=false, Crsel=false, D=false, D0=false,
    D1=false, D2=false, D3=false, D4=false, D5=false, D6=false, D7=false, D8=false, D9=false, Decimal=false, Delete=false,
    Divide=false, Down=false, E=false, End=false, Enter=false, EraseEof=false, Escape=false, Execute=false, Exsel=false,
    F=false, F1=false, F10=false, F11=false, F12=false, F13=false, F14=false, F15=false, F16=false, F17=false, F18=false,
    F19=false, F2=false, F20=false, F21=false, F22=false, F23=false, F24=false, F3=false, F4=false, F5=false, F6=false,
    F7=false, F8=false, F9=false, FinalMode=false, G=false, H=false, HanguelMode=false, HangulMode=false, HanjaMode=false,
    Help=false, Home=false, I=false, IMEAccept=false, IMEAceept=false, IMEConvert=false, IMEModeChange=false,
    IMENonconvert=false, Insert=false, J=false, JunjaMode=false, K=false, KanaMode=false, KanjiMode=false, KeyCode=false,
    L=false, LaunchApplication1=false, LaunchApplication2=false, LaunchMail=false, LButton=false, LControlKey=false,
    Left=false, LineFeed=false, LMenu=false, LShiftKey=false, LWin=false, M=false, MButton=false, MediaNextTrack=false,
    MediaPlayPause=false, MediaPreviousTrack=false, MediaStop=false, Menu=false, Modifiers=false, Multiply=false, N=false,
    Next=false, NoName=false, None=false, NumLock=false, NumPad0=false, NumPad1=false, NumPad2=false, NumPad3=false,
    NumPad4=false, NumPad5=false, NumPad6=false, NumPad7=false, NumPad8=false, NumPad9=false, O=false, Oem1=false,
    Oem102=false, Oem2=false, Oem3=false, Oem4=false, Oem5=false, Oem6=false, Oem7=false, Oem8=false, OemBackslash=false,
    OemClear=false, OemCloseBrackets=false, Oemcomma=false, OemMinus=false, OemOpenBrackets=false, OemPeriod=false,
    OemPipe=false, Oemplus=false, OemQuestion=false, OemQuotes=false, OemSemicolon=false, Oemtilde=false, P=false, Pa1=false,
    Packet=false, PageDown=false, PageUp=false, Pause=false, Play=false, Print=false, PrintScreen=false, Prior=false,
    ProcessKey=false, Q=false, R=false, RButton=false, RControlKey=false, Return=false, Right=false, RMenu=false, RShiftKey=false,
    RWin=false, S=false, Scroll=false, Select=false, SelectMedia=false, Separator=false, Shift=false, ShiftKey=false,
    Sleep=false, Snapshot=false, Space=false, Subtract=false, T=false, Tab=false, U=false, Up=false, V=false, VolumeDown=false,
    VolumeMute=false, VolumeUp=false, W=false, X=false, XButton1=false, XButton2=false, Y=false, Z=false, Zoom=false
}

local function hexdecode(hex)
   return (hex:gsub("%x%x", function(digits) return string.char(tonumber(digits, 16)) end))
end

local function hexencode(str)
   return (str:gsub(".", function(char) return string.format("%2x", char:byte()) end))
end

function dec2Hex(val)
	if val >= 0 and val < 16 then
		return string.format("0%X", tonumber(val))
	elseif val > 15 and val < 128 then
		return string.format("%X", tonumber(val))
	elseif val == 0 then
		return "00"
	elseif val < 0 and val > -128 then
	    return string.sub(string.format("%X", tostring(val)), 15)
	end
end

--memory.getcurrentmemorydomainsize()
--memory.usememorydomain("NOME DA MEMORIA QUE VOCÊ QUER ACESSAR") - IMPORATANTE
local memory_w = memory.writebyte
local Mu = 0
local Se = 0
local d_key = 0;
local d_key_2 = 0;
local d_key_3 = 0;
local page_debug = 0;
local check_soundl = 0;
--local tmp = input.get()
     -- [0] = memory.writebyte(0x009896,17)
     -- [1] = memory.writebyte(0x009897,32)
     -- [2] = memory.writebyte(0x009898,10)
     -- [3] = memory.writebyte(0x009899,32)
     -- [4] = memory.writebyte(0x00989A,27)
     -- [5] = memory.writebyte(0x00989B,32)
     -- [6] = memory.writebyte(0x00989C,13)
     -- [7] = memory.writebyte(0x00989D,32)
     -- [8] = memory.writebyte(0x00989E,255)
     -- [9] = memory.writebyte(0x00989F,28)
     -- [10] = memory.writebyte(0x0098A0, 241)
     -- [11] = memory.writebyte(0x0098A1,28)
     -- [12] = memory.writebyte(0x0098A2,22)
     -- [13] = memory.writebyte(0x0098A3,32)
     -- [14] = memory.writebyte(0x0098A4,24)
     -- [15] = memory.writebyte(0x0098A5,32)
     -- [16] = memory.writebyte(0x0098A6,13)
     -- [17] = memory.writebyte(0x0098A7,32)
     -- [18] = memory.writebyte(0x0098A8,14)
     -- [19] = memory.writebyte(0x0098A9,32)
local Infor_view = 0
local check_press = 0
while true do 
local type_select = mainmemory.readbyte(0x000C11);
--KEY ADD VALUE TO ADDRESS 
local next_page = input.get()
local User_input = INPUT_KEYNAMES

User_input.R = next_page.R
User_input.E = next_page.E
User_input.T = next_page.T
User_input.Q = next_page.Q
User_input.Alt = next_page.Alt

--Hide Information:
if mainmemory.readbyte(0x000C10) == 2 then 
       if next_page.Q == true and check_press == 0 then 
       Infor_view = Infor_view + 1 
       end 
       
       if next_page.Q == true then 
       check_press = 1 
       else 
       check_press = 0 
       end 
       
       if Infor_view > 1 then 
       Infor_view = 0 
       end 
--====================================================

       --ADD VALUE 
       if next_page.R == true and next_page.Alt == true and d_key == 0 then 
          if type_select == 2 then 
          Se = Se + 9
          elseif type_select == 0 then 
          Mu = Mu + 9 
          end 
       end 
       
       if next_page.R == true and d_key == 0 then
          if type_select == 2 then 
          Se = Se + 1
          elseif type_select == 0 then 
          Mu = Mu + 1 
          end 
       end 
       
       if next_page.R == true then 
       d_key = 1 
       else 
       d_key = 0
       end 
       
       --REMOVE VALUE 
       if next_page.E == true and d_key_2 == 0 then
          if type_select == 2 then 
          Se = Se - 1
          elseif type_select == 0 then 
          Mu = Mu - 1 
          end 
       end 
       
       if Mu < 0 then 
       Mu = 255 
       end 
       
       if Se < 0 then 
       Se = 255
       end 
       
       if next_page.E == true then 
       d_key_2 = 1 
       else 
       d_key_2 = 0
       end 
       
       --RESET VALUE 
       if next_page.T == true then
          if type_select == 2 then 
          Se = 0
          elseif type_select == 0 then 
          Mu = 0 
          end 
       end 
       
       --====================================================
       memory.usememorydomain("WRAM")
       
       local SoundE_ID = string.format("%03d",mainmemory.readbyte(0x000C17))
       local Music_ID = string.format("%03d",mainmemory.readbyte(0x000C16))
       
       local SoundE_part = {
       [1] = string.sub(SoundE_ID,1,1);
       [2] = string.sub(SoundE_ID,2,2);
       [3] = string.sub(SoundE_ID,3,3);
       } 
       
       local Music_part = {
       [1] = string.sub(Music_ID,1,1);
       [2] = string.sub(Music_ID,2,2);
       [3] = string.sub(Music_ID,3,3);
       } 
       
       memory.writebyte(0x000C17,Se) --Sound Effect ID 
       memory.writebyte(0x000C16,Mu) -- Music ID 
       memory.writebyte(0x000C15,01) -- Delay Player Sound 
       memory.writebyte(0x000B75,22)
       memory.writebyte(0x000B65,00)
       
       memory.usememorydomain("VRAM")
	   --Draw Text on Screen (VRAM):
       local Draw_Text_1 = {
       --TITLE 
       [1] = memory.writebyte(0xB112,tonumber(0x0F));
       [2] = memory.writebyte(0xB113,tonumber(0x20));--F 
       
       [3] = memory.writebyte(0xB114,tonumber(0x1E));
       [4] = memory.writebyte(0xB115,tonumber(0x20));--U
       
       [5] = memory.writebyte(0xB116,tonumber(0x15));
       [6] = memory.writebyte(0xB117,tonumber(0x20));--L
       
       [7] = memory.writebyte(0xB118,tonumber(0x15));
       [8] = memory.writebyte(0xB119,tonumber(0x20));--L
       
       --SPACE 
       
       [9] = memory.writebyte(0xB120,tonumber(0x1F)); 
       [10] = memory.writebyte(0xB121,tonumber(0x20));--V 
       
       [11] = memory.writebyte(0xB122,tonumber(0x0E)); 
       [12] = memory.writebyte(0xB123,tonumber(0x20));--E 
       
       [13] = memory.writebyte(0xB124,tonumber(0x1B)); 
       [14] = memory.writebyte(0xB125,tonumber(0x20));--R 
       
       [15] = memory.writebyte(0xB126,tonumber(0x1C)); 
       [16] = memory.writebyte(0xB127,tonumber(0x20));--S 
       
       [17] = memory.writebyte(0xB128,tonumber(0x12)); 
       [18] = memory.writebyte(0xB129,tonumber(0x20));--I 
       
       [19] = memory.writebyte(0xB12A,tonumber(0x18)); 
       [20] = memory.writebyte(0xB12B,tonumber(0x20));--O 
       
       [21] = memory.writebyte(0xB12C,tonumber(0x17)); 
       [22] = memory.writebyte(0xB12D,tonumber(0x20));--N 
       } 
       
       --====================================================
       
       local Draw_text_2 = { 
       --SOUND EFFECT VALUE:
       [1] = memory.writebyte(0xB396,tonumber(0x1F));
       [2] = memory.writebyte(0xB397,tonumber(0x30));--V 
       						
       [3] = memory.writebyte(0xB398,tonumber(0x0A));
       [4] = memory.writebyte(0xB399,tonumber(0x30));--A 
       						
       [5] = memory.writebyte(0xB39A,tonumber(0x15));
       [6] = memory.writebyte(0xB39B,tonumber(0x30));--L
       						
       [7] = memory.writebyte(0xB39C,tonumber(0x1E));
       [8] = memory.writebyte(0xB39D,tonumber(0x30));--U 
       						
       [9]  = memory.writebyte(0xB39E,tonumber(0x0E));
       [10] = memory.writebyte(0xB39F,tonumber(0x30));--E
       						
       [11] = memory.writebyte(0xB3A0,tonumber(0x29));
       [12] = memory.writebyte(0xB3A1,tonumber(0x30));--:
       
       -- SPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACE
       
       [13] = memory.writebyte(0xB3A6,tonumber(Music_part[1]) );
       [14] = memory.writebyte(0xB3A7,tonumber(0x30)          );--NUMBER 1
       						
       [15] = memory.writebyte(0xB3A8,tonumber(Music_part[2]) );
       [16] = memory.writebyte(0xB3A9,tonumber(0x30)          );--NUMBER 2 
       
       [15] = memory.writebyte(0xB3AA,tonumber(Music_part[3]) );
       [18] = memory.writebyte(0xB3AB,tonumber(0x30)          );--NUMBER 3 
       
       }
       
       --==============================================================
       
       local Draw_text_3 = { 
       --SOUND MUSIC VALUE:
       [1] = memory.writebyte(0xB456,tonumber(0x1F));
       [2] = memory.writebyte(0xB457,tonumber(0x24));--V 
       						
       [3] = memory.writebyte(0xB458,tonumber(0x0A));
       [4] = memory.writebyte(0xB459,tonumber(0x24));--A 
       						
       [5] = memory.writebyte(0xB45A,tonumber(0x15));
       [6] = memory.writebyte(0xB45B,tonumber(0x24));--L
       						
       [7] = memory.writebyte(0xB45C,tonumber(0x1E));
       [8] = memory.writebyte(0xB45D,tonumber(0x24));--U 
       						
       [9] = memory.writebyte(0xB45E,tonumber(0x0E));
       [10] = memory.writebyte(0xB45F,tonumber(0x24));--E 
       						
       [11] = memory.writebyte(0xB460,tonumber(0x29));
       [12] = memory.writebyte(0xB461,tonumber(0x24));--: 
       
       -- SPAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACE
       
       [13] = memory.writebyte(0xB466,tonumber(SoundE_part[1]));
       [14] = memory.writebyte(0xB467,tonumber(0x24)          );--NUMBER 1
       						
       [15] = memory.writebyte(0xB468,tonumber(SoundE_part[2]));
       [16] = memory.writebyte(0xB469,tonumber(0x24)          );--NUMBER 2 
       
       [17] = memory.writebyte(0xB46A,tonumber(SoundE_part[3]));
       [18] = memory.writebyte(0xB46B,tonumber(0x24)          );--NUMBER 3 
       
       }
       gui.pixelText(4*21,8*8,"Script By VMMR","lightgreen","",0)
       if Infor_view == 0 then  
       --INFORMATIONS:
       gui.pixelText(4,8*22,"Key Q:Hide Info","white","",0)
       gui.pixelText(4,8*23,"Key R:Add +1","white","",0)
       gui.pixelText(4,8*24,"Key R + Alt:Add +10","white","",0)
       gui.pixelText(4,8*25,"Key E:Add -1","white","",0)
       gui.pixelText(4,8*26,"Key T:Return 0","white","",0)
       end 
end 
--======================================
emu.frameadvance();
end 