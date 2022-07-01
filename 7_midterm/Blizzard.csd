<Cabbage> bounds(0, 0, 0, 0)
form caption("Blizzard") size(520, 500), guiMode("queue"), pluginId("def7") colour(0, 0, 0, 255)

;Create a groupbox for the GENERATOR module.
groupbox bounds(0, 0, 260, 135) channel("OSCILLATOR")  corners(0) lineThickness(0) colour(36, 55, 108, 255) outlineColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) outlineThickness(2)  

;Control voice amount
combobox bounds(214, 88, 35, 20) channel("Voices") text("1", "2", "3", "4", "5", "6") value(6)
label bounds(212, 115, 40, 10) channel("label10068") text("Voices") fontColour(255, 255, 255, 255)

;Controls for the carrier/oscillator ADSR
rslider bounds(50, 80, 35, 35) channel("Attack") range(0.001, 1, 0.1, 1, 0.001) popupPrefix("Osc Atk: ") trackerColour(148, 162, 243, 255)
rslider bounds(90, 80, 35, 35) channel("Decay") range(0.001, 1, 0.25, 1, 0.001) popupPrefix("Osc Dec: ") trackerColour(148, 162, 243, 255)
rslider bounds(130, 80, 35, 35) channel("Sustain") range(0, 1, 0.75, 1, 0.001) popupPrefix("Osc Sus: ") trackerColour(148, 162, 243, 255)
rslider bounds(170, 80, 35, 35) channel("Release") range(0.001, 1, 0.25, 1, 0.001) popupPrefix("Osc Rel: ") trackerColour(148, 162, 243, 255)

;Controls for the modulator ADSR
rslider bounds(50, 20, 35, 35) channel("ModAttack") range(0.001, 1, 0.1, 1, 0.001) popupPrefix("Mod Atk: ") trackerColour(148, 162, 243, 255)
rslider bounds(90, 20, 35, 35) channel("ModDecay") range(0, 1, 0.25, 1, 0.001) popupPrefix("Mod Dec: ") trackerColour(148, 162, 243, 255)
rslider bounds(130, 20, 35, 35) channel("ModSustain") range(0.001, 1, 0.75, 1, 0.001) popupPrefix("Mod Sus: ") trackerColour(148, 162, 243, 255)
rslider bounds(170, 20, 35, 35) channel("ModRelease") range(0.001, 1, 0.25, 1, 0.001) popupPrefix("Mod Rel: ") trackerColour(148, 162, 243, 255) 

;Additional control for FM synthesis
rslider bounds(212, 28, 40, 40) channel("fmFreq") range(0.01, 0.25, 0.12, 1, 0.001) popupPrefix("Mod Freq: ") trackerColour(148, 162, 243, 255)
label bounds(207, 71, 50, 10) channel("label10069") text("Mod Freq") fontColour(255, 255, 255, 255)

;Labels for the ADSR controls
label bounds(50, 56, 35, 20) channel("label10014") text("A") fontColour(255, 255, 255, 255)
label bounds(90, 56, 35, 20) channel("label10015") text("D") fontColour(255, 255, 255, 255)
label bounds(130, 56, 35, 20) channel("label10016") text("S") fontColour(255, 255, 255, 255)
label bounds(170, 56, 35, 20) channel("label10017") text("R") fontColour(255, 255, 255, 255)

;Select between different waveforms or a simple FM.
checkbox bounds(30, 20, 15, 15) channel("enableFM") radioGroup("1") popupText("FM") colour:1(0, 226, 255, 255)
checkbox bounds(30, 40, 15, 15) channel("enableSin") radioGroup("1") popupText("Sine") value(1) colour:1(0, 226, 255, 255)
checkbox bounds(30, 60, 15, 15) channel("enableTri") radioGroup("1") popupText("Triangle") value(0) colour:1(0, 226, 255, 255)
checkbox bounds(30, 80, 15, 15) channel("enableSqr") radioGroup("1") popupText("Square") value(0) colour:1(0, 226, 255, 255)
checkbox bounds(30, 100, 15, 15) channel("enableSaw") radioGroup("1") popupText("Sawtooth") value(0) colour:1(0, 226, 255, 255)

label bounds(5, 21, 20, 10) channel("label10063") text("FM") align("right") fontColour(255, 255, 255, 255)
label bounds(5, 41, 20, 10) channel("label10064") text("Sin") align("right") fontColour(255, 255, 255, 255)
label bounds(5, 61, 20, 10) channel("label10065") text("Tri") align("right") fontColour(255, 255, 255, 255)
label bounds(5, 81, 20, 10) channel("label10066") text("Sqr") align("right") fontColour(255, 255, 255, 255)
label bounds(5, 101, 20, 10) channel("label10067") text("Saw") align("right") fontColour(255, 255, 255, 255)


;Groupbox for the JUST HARMONY module
groupbox bounds(0, 135, 260, 55) channel("HARMONIZER") corners(0) lineThickness(0) outlineThickness(2) outlineColour(0, 0, 0, 255) fontColour(0, 0, 0, 255) colour(36, 31, 96, 255)

;Checkboxes to enable various intervals
checkbox bounds(30, 148, 10, 15) channel("HarmMin3rd") popupText("Minor 3rd") colour:1(0, 226, 255, 255)
checkbox bounds(50, 148, 10, 15) channel("Harm3rd") popupText("Major 3rd") colour:1(0, 226, 255, 255)
checkbox bounds(70, 148, 10, 15) channel("Harm4th") popupText("Perfect 4th") colour:1(0, 226, 255, 255)
checkbox bounds(90, 148, 10, 15) channel("Harm5th") popupText("Perfect 5th") colour:1(0, 226, 255, 255)
checkbox bounds(110, 148, 10, 15) channel("HarmMin6th") popupText("Minor 6th") colour:1(0, 226, 255, 255)
checkbox bounds(130, 148, 10, 15) channel("Harm6th") popupText("Major 6th") colour:1(0, 226, 255, 255)
checkbox bounds(150, 148, 10, 15) channel("Harm7th") popupText("Minor 7th") colour:1(0, 226, 255, 255)
checkbox bounds(170, 148, 10, 15) channel("HarmMaj7th") popupText("Major 7th") colour:1(0, 226, 255, 255)
checkbox bounds(190, 148, 10, 15) channel("HarmOct") popupText("Octave") colour:1(0, 226, 255, 255)

label bounds(24, 170, 20, 10) channel("label10054")  text("m3") fontColour(255, 255, 255, 255)
label bounds(44, 170, 20, 10) channel("label10055") text("M3") fontColour(255, 255, 255, 255)
label bounds(65, 170, 20, 10) channel("label10056") text("4th") fontColour(255, 255, 255, 255)
label bounds(85, 170, 20, 10) channel("label10057") text("5th") fontColour(255, 255, 255, 255) 
label bounds(105, 170, 20, 10) channel("label10058") text("m6") fontColour(255, 255, 255, 255) 
label bounds(125, 170, 20, 10) channel("label10059") text("M6") fontColour(255, 255, 255, 255)
label bounds(145, 170, 20, 10) channel("label10060") text("m7")  fontColour(255, 255, 255, 255)
label bounds(165, 170, 20, 10) channel("label10061") text("M7") fontColour(255, 255, 255, 255)
label bounds(185, 170, 20, 10) channel("label10062") text("Oct") fontColour(255, 255, 255, 255)

;Amplitude control for harmony notes
rslider bounds(216, 144, 25, 25) channel("HarmAmp") range(0, 1, 1, 1, 0.01) popupPrefix("Harmony Level: ") trackerColour(148, 162, 243, 255)

;Group box for misc. controls
groupbox bounds(0, 190, 260, 85) channel("OSCCONTROLS") corners(0) lineThickness(0) outlineThickness(2) outlineColour(0, 0, 0, 255) colour(36, 55, 108, 255)

button bounds(20, 214, 20, 20) channel("enableSynth") corners(10)  latched(1) colour:1(255, 0, 0, 255) text("") popupText("Enable Synth") value(1)
label bounds(10, 238, 40, 10) channel("label10197") text("Enable") fontColour(255, 255, 255, 255)

;Detune
rslider bounds(63, 199, 50, 50) channel("Detune") range(0, 1, 0, 1, 0.01) trackerColour(148, 162, 243, 255)
;Fine tune
rslider bounds(132, 199, 50, 50) channel("Fine") range(-100, 100, 0, 1, 1) trackerColour(148, 162, 243, 255)
;Sync phase
checkbox bounds(205, 203, 40, 40) channel("Sync") colour:0(250, 0, 71, 255) colour:1(0, 0, 0, 255) corners(5)

label bounds(63, 252, 50, 13) channel("label10051") text("Detune") fontColour(255, 255, 255, 255)
label bounds(132, 252, 50, 13) channel("label10052") text("Fine") fontColour(255, 255, 255, 255)
label bounds(205, 252, 40, 13) channel("label10053") text("Sync") fontColour(255, 255, 255, 255)

;Groupbox for the NOISE MODULE
groupbox bounds(0, 276, 260, 151) channel("NOISE") corners(0) lineThickness(0) outlineThickness(2) colour(50, 50, 96, 255) outlineColour(0, 0, 0, 255)

;Enable or disable noise
button bounds(20, 292, 20, 20) channel("enableNoise") corners(10)  latched(1) colour:1(255, 0, 0, 255) text("") popupText("Enable Noise")
label bounds(10, 317, 40, 10) channel("label10097") text("Enable") fontColour(255, 255, 255, 255)

;Noise setting
vslider bounds(74, 295, 10, 30) channel("NoiseType") range(0, 1, 0, 1, 1) popupText("0") trackerColour(147, 210, 0, 0)
label bounds(64, 323, 30, 10) channel("label10037") text("white") fontColour(255, 255, 255, 255) 
label bounds(64, 283, 30, 10) channel("label10038") text("pink") fontColour(255, 255, 255, 255)

;ADSR for noise
rslider bounds(106, 287, 30, 30) channel("NoiseAtk") range(0.001, 1, 0.001, 1, 0.001) popupPrefix("Noise Atk: ") trackerColour(148, 162, 243, 255)
rslider bounds(141, 287, 30, 30) channel("NoiseDec") range(0.001, 1, 0.33, 1, 0.001) popupPrefix("Noise Dec: ") trackerColour(148, 162, 243, 255)
rslider bounds(176, 287, 30, 30) channel("NoiseSus") range(0, 1, 0.75, 1, 0.001) popupPrefix("Noise Sus: ") trackerColour(148, 162, 243, 255)
rslider bounds(211, 287, 30, 30) channel("NoiseRel") range(0.001, 1, 0.1, 1, 0.001) popupPrefix("Noise Rel: ") trackerColour(148, 162, 243, 255)

label bounds(110, 318, 21, 14) channel("label10072") text("A") fontColour(255, 255, 255, 255)
label bounds(146, 318, 21, 14) channel("label10073") text("D") fontColour(255, 255, 255, 255)
label bounds(180, 318, 21, 14) channel("label10074") text("S") fontColour(255, 255, 255, 255)
label bounds(216, 318, 20, 14) channel("label10075") text("R") fontColour(255, 255, 255, 255)

;Filter control for noise
rslider bounds(54, 350, 50, 50) channel("NoiseFilterFreq") range(20, 15000, 3000, 1, 1) popupPrefix("Cutoff Freq: ") trackerColour(148, 162, 243, 255)
rslider bounds(116, 360, 40, 40) channel("NoiseFilterQ") range(1, 50, 10, 1, 0.01) popupPrefix("Filter Q: ") trackerColour(148, 162, 243, 255)
label bounds(52, 400, 54, 16) channel("label10070") text("Cutoff") fontColour(255, 255, 255, 255)
label bounds(126, 400, 20, 16) channel("label10071") text("Q") fontColour(255, 255, 255, 255)

vslider bounds(166, 350, 10, 50) channel("NoiseFilterType") range(0, 3, 0, 1, 1) popupText("0") trackerColour(147, 210, 0, 0)
label bounds(182, 346, 15, 10) channel("label10046") text("LP") fontColour(255, 255, 255, 255) fontColour(255, 255, 255, 255)
label bounds(182, 360, 15, 10) channel("label10047") text("BP") fontColour(255, 255, 255, 255) fontColour(255, 255, 255, 255)
label bounds(182, 374, 15, 10) channel("label10048") text("HP") fontColour(255, 255, 255, 255) fontColour(255, 255, 255, 255)
label bounds(182, 388, 35, 10) channel("label10049") text("Bypass") fontColour(255, 255, 255, 255) fontColour(255, 255, 255, 255)

;Groupbox for Osc Filter
groupbox bounds(260, 0, 260, 190) channel("groupbox10087") lineThickness(0) corners(0) outlineThickness(2) outlineColour(0, 0, 0, 255) colour(47, 30, 77, 255)

;Filter controls
rslider bounds(298, 14, 60, 60) channel("preFilterCut") range(20, 15000, 3000, 1, 1) popupPrefix("Cutoff Freq: ") trackerColour(148, 162, 243, 255)
rslider bounds(370, 30, 45, 45) channel("preFilterQ") range(1, 50, 10, 1, 0.01) popupPrefix("Filter Q: ") trackerColour(148, 162, 243, 255)
vslider bounds(430, 14, 10, 60) channel("preFilterType") range(0, 3, 0, 1, 1) popupText("0") trackerColour(148, 162, 243, 0)

;Filter envelope controls
rslider bounds(312, 114, 40, 40) channel("preFilterAtk") range(0.001, 1, 0.001, 1, 0.001) popupPrefix("Filter Atk: ") trackerColour(148, 162, 243, 255)
rslider bounds(366, 114, 40, 40) channel("preFilterDec") range(0.001, 1, 0.25, 1, 0.001) popupPrefix("Filter Dec: ") trackerColour(148, 162, 243, 255)
rslider bounds(420, 104, 50, 50) channel("preFilterAmp") range(0, 10, 2, 1, 0.001)  popupPrefix("Filter Env: ") trackerColour(148, 162, 243, 255)

;Labels
label bounds(298, 74, 60, 16) channel("label10085") text("Cutoff") fontColour(255, 255, 255, 255)
label bounds(370, 74, 45, 16) channel("label10086") text("Q") fontColour(255, 255, 255, 255)
label bounds(446, 59, 35, 10) channel("label10087") text("Bypass") align("left") fontColour(255, 255, 255, 255)
label bounds(446, 44, 35, 10) channel("label10088") text("HP") align("left") fontColour(255, 255, 255, 255)
label bounds(446, 29, 35, 10) channel("label10089") align("left") text("BP") fontColour(255, 255, 255, 255)
label bounds(446, 14, 35, 10) channel("label10090") text("LP") align("left") fontColour(255, 255, 255, 255)
label bounds(312, 154, 40, 16) channel("label10091") text("Atk") fontColour(255, 255, 255, 255)
label bounds(366, 154, 40, 16) channel("label10092") text("Dec") fontColour(255, 255, 255, 255)
label bounds(420, 154, 50, 16) channel("label10093") text("Env") fontColour(255, 255, 255, 255)

;Freeze and Blur buttons
groupbox bounds(260, 310, 259, 116) channel("groupbox10100") corners(0) outlineThickness(2) outlineColour(0, 0, 0, 0) colour(181, 221, 255, 255) lineThickness(0)

button bounds(390, 190, 130, 120) channel("Freeze") text("Freeze", "Freeze") colour:1(118, 232, 255, 255) latched(0)
button bounds(260, 190, 130, 120) channel("Blur") text("Blur", "Blur") colour:1(118, 232, 255, 255)
rslider bounds(292, 316, 80, 80) channel("fftQuality") range(1, 8, 4, 1, 1) popupPrefix("Quality: ") trackerColour(148, 162, 243, 255)
rslider bounds(406, 316, 80, 80) channel("fftSmooth") range(0, 1, 0.5, 1, 0.001) popupPrefix("Blur Amount: ") trackerColour(148, 162, 243, 255)

label bounds(292, 398, 80, 16) channel("label10098") text("Quality") fontColour(0, 0, 0, 255)
label bounds(396, 398, 100, 16) channel("label10099") text("Blur Amount") fontColour(0, 0, 0, 255)

keyboard bounds(0, 428, 520, 72) channel("keyboard14")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>
<CsInstruments>

ksmps = 32
nchnls = 2
0dbfs = 1

;Use system clock for random seed
seed 0

;Main oscillator with interval harmony settings
opcode generator, a, ikkaiiiiiiiiiiik

    ;Accept these arguments for the instrument
    iAmp, kCps, kModFreq, aModEnv, iOscMode, iPhase, \ 
    iEnableMin3, iEnable3rd, iEnable4th, iEnable5th, iEnableMin6, iEnable6th, iEnable7th, iEnableMaj7, iEnableOct, kHarmAmp xin
    
    ;Check iOscMode and change the iMode accordingly
    if iOscMode == 2 then ;Triangle
        iMode = 12
    elseif iOscMode == 3 then ;Square
        iMode = 10
    elseif iOscMode == 4 then ;Sawtooth
        iMode = 4
    else
        iMode = 0
    endif
    
    ;Create modulator for FM synthesis
    aMod oscil iAmp, kCps*kModFreq
    aMod *= aModEnv
    
    ;Sine oscillator, check if FM is enabled
    if iOscMode == 0 then
        aSine oscil iAmp, kCps*aMod, -1, iPhase
    elseif iOscMode == 1 then
        aSine oscil iAmp, kCps, -1, iPhase
    else
        ;do nothing
    endif
    
    ;Triangle, square and sawtooth oscillators
    aWave vco2 iAmp, kCps, iMode, 0.001, iPhase
    
    ;Add harmonies, based on just intonation intervals.
    ;Also generate a new modulator for each harmony.
    if iEnableMin3 == 1 then
        if iOscMode == 0 then
            aModMin3rd oscil iAmp, (kCps*(6/5))*kModFreq
            aModMin3rd *= aModEnv
            aMin3rd oscil iAmp, (kCps*(6/5))*aModMin3rd, -1, iPhase
            aSine += aMin3rd*kHarmAmp
        else
            aWavMin3rd vco2 iAmp, kCps*(6/5), iMode, 0.001
            aMin3rd oscil iAmp, kCps*(6/5), -1, iPhase
            aWave += aWavMin3rd*kHarmAmp
            aSine += aMin3rd*kHarmAmp
        endif
    endif
    if iEnable3rd == 1 then
        if iOscMode == 0 then
            aMod3rd oscil iAmp, (kCps*(5/4))*kModFreq
            aMod3rd *= aModEnv
            a3rd oscil iAmp, (kCps*(5/4))*aMod3rd, -1, iPhase
            aSine += a3rd*kHarmAmp
        else
            aWav3rd vco2 iAmp, kCps*(5/4), iMode, 0.001, iPhase
            a3rd oscil iAmp, kCps*(5/4), -1, iPhase
            aWave += aWav3rd*kHarmAmp
            aSine += a3rd*kHarmAmp
        endif
    endif
    if iEnable4th == 1 then
        if iOscMode == 0 then
            aMod4th oscil iAmp, (kCps*(4/3))*kModFreq
            aMod4th *= aModEnv
            a4th oscil iAmp, (kCps*(4/3))*aMod4th, -1, iPhase
            aSine += a4th*kHarmAmp
        else
            aWav4th vco2 iAmp, kCps*(4/3), iMode, 0.001, iPhase
            a4th oscil iAmp, kCps*(4/3), -1, iPhase
            aWave += aWav4th*kHarmAmp
            aSine += a4th*kHarmAmp
        endif
    endif
    if iEnable5th == 1 then
        if iOscMode == 0 then
            aMod5th oscil iAmp, (kCps*(3/2))*kModFreq
            aMod5th *= aModEnv
            a5th oscil iAmp, (kCps*(3/2))*aMod5th, -1, iPhase
            aSine += a5th*kHarmAmp
        else
            aWav5th vco2 iAmp, kCps*(3/2), iMode, 0.001, iPhase
            a5th oscil iAmp, kCps*(3/2), -1, iPhase
            aWave += aWav5th*kHarmAmp
            aSine += a5th*kHarmAmp
        endif
    endif
    if iEnableMin6 == 1 then
        if iOscMode == 0 then
            aModMin6th oscil iAmp, (kCps*(8/5))*kModFreq
            aModMin6th *= aModEnv
            aMin6th oscil iAmp, (kCps*(8/5))*aModMin6th, -1, iPhase
            aSine += aMin6th*kHarmAmp
        else
            aWavMin6th vco2 iAmp, kCps*(8/5), iMode, 0.001, iPhase
            aMin6th oscil iAmp, kCps*(8/5), -1, iPhase
            aWave += aWavMin6th*kHarmAmp
            aSine += aMin6th*kHarmAmp
        endif
    endif
    if iEnable6th == 1 then
        if iOscMode == 0 then
            aMod6th oscil iAmp, (kCps*(5/3))*kModFreq
            aMod6th *= aModEnv
            a6th oscil iAmp, (kCps*(5/3))*aMod6th, -1, iPhase
            aSine += aMin3rd*kHarmAmp
        else
            aWav6th vco2 iAmp, kCps*(5/3), iMode, 0.001, iPhase
            a6th oscil iAmp, kCps*(5/3), -1, iPhase
            aWave += aWav6th*kHarmAmp
            aSine += a6th*kHarmAmp
        endif
    endif
    if iEnable7th == 1 then
        if iOscMode == 0 then
            aMod7th oscil iAmp, (kCps*(16/9))*kModFreq
            aMod7th *= aModEnv
            a7th oscil iAmp, (kCps*(16/9))*aMod7th, -1, iPhase
            aSine += a7th*kHarmAmp
        else
            aWav7th vco2 iAmp, kCps*(16/9), iMode, 0.001, iPhase
            a7th oscil iAmp, kCps*(16/9), -1, iPhase
            aWave += aWav7th*kHarmAmp
            aSine += a7th*kHarmAmp
        endif
    endif
    if iEnableMaj7 == 1 then
        if iOscMode == 0 then
            aModMaj7th oscil iAmp, (kCps*(15/8))*kModFreq
            aModMaj7th *= aModEnv
            aMaj7th oscil iAmp, (kCps*(15/8))*aModMaj7th, -1, iPhase
            aSine += aMaj7th*kHarmAmp
        else
            aWavMaj7th vco2 iAmp, kCps*(15/8), iMode, 0.001, iPhase
            aMaj7th oscil iAmp, kCps*(15/8), -1, iPhase
            aWave += aWavMaj7th*kHarmAmp
            aSine += aMaj7th*kHarmAmp
        endif
    endif
    if iEnableOct == 1 then
        if iOscMode == 0 then
            aModOct oscil iAmp, (kCps*2)*kModFreq
            aModOct *= aModEnv
            aOct oscil iAmp, (kCps*2)*aModOct, -1, iPhase
            aSine += aOct*kHarmAmp
        else
            aWavOct vco2 iAmp, kCps*2, iMode, 0.001, iPhase
            aOct oscil iAmp, kCps*2, -1, iPhase
            aWave += aWavOct*kHarmAmp
            aSine += aOct*kHarmAmp
        endif
    endif
    
    ;Send either vco2 or oscil to aOut
    if iOscMode >= 2 then
        aOut = aWave
    else
        aOut = aSine
    endif
    
    xout aOut
endop

;MIDI CONTROLLED INSTRUMENT
instr 1

    ;Get ADSR controls for the carrier
    iOscAtk cabbageGetValue "Attack"
    iOscDec cabbageGetValue "Decay"
    iOscSus cabbageGetValue "Sustain"
    iOscRel cabbageGetValue "Release"
    
    ;Get ADSR controls for the modulator
    iModAtk cabbageGetValue "ModAttack"
    iModDec cabbageGetValue "ModDecay"
    iModSus cabbageGetValue "ModSustain"
    iModRel cabbageGetValue "ModRelease"
    
    kModFreq cabbageGetValue "fmFreq"
    
    ;Read waveform setting
    kEnableFM  cabbageGetValue "enableFM"
    kEnableSin cabbageGetValue "enableSin"
    kEnableTri cabbageGetValue "enableTri"
    kEnableSqr cabbageGetValue "enableSqr"
    kEnableSaw cabbageGetValue "enableSaw"
    
    ;Check harmony settings
    iMin3 cabbageGetValue "HarmMin3rd"
    i3rd cabbageGetValue "Harm3rd"
    i4th cabbageGetValue "Harm4th"
    i5th cabbageGetValue "Harm5th"
    iMin6 cabbageGetValue "HarmMin6th"
    i6th cabbageGetValue "Harm6th"
    i7th cabbageGetValue "Harm7th"
    iMaj7 cabbageGetValue "HarmMaj7th"
    iOct cabbageGetValue "HarmOct"
    
    kHarmAmp cabbageGetValue "HarmAmp"
    
    ;Check voice amount
    kVoices cabbageGetValue "Voices"
    
    ;Control vibrato through mod wheel
    kVibAmount ctrl7 1, 1, 0, 0.2
    kVib lfo kVibAmount, 10
    kVib += 1
    
    ;Create a symmetrical detune (voices get tuned both up and down) based on the detune amount.
    kDetuneCtrl cabbageGetValue "Detune"
    kDetuneUp1 = (kDetuneCtrl*0.04)+1
    kDetuneDown1 = (kDetuneCtrl*-0.04)+1
    kDetuneUp2 = (kDetuneCtrl*0.025)+1
    kDetuneDown2 = (kDetuneCtrl*-0.025)+1
    kDetuneUp3 = (kDetuneCtrl*0.01)+1
    kDetuneDown3 = (kDetuneCtrl*-0.01)+1
    
    ;No need to detune if there's only one voice. Use fine tune instead.
    if kVoices = 1 then
        kDetuneUp1 = 1
    endif
    
    ;Get fine tune control
    kFineCtrl cabbageGetValue "Fine"
    kFineTune = cent(kFineCtrl)
    
    ;Check phase control
    iSync cabbageGetValue "Sync"
    
    ;Random generators for random phase. 
    ;If Sync is enabled (= 0) then multiply by zero to set the phase to 0 for all oscillators.
    kRand1 random 0, 1
    kRand1 *= iSync
    
    kRand2 random 0, 1
    kRand2 *= iSync
    
    kRand3 random 0, 1
    kRand3 *= iSync
    
    kRand4 random 0, 1
    kRand4 *= iSync
    
    kRand5 random 0, 1
    kRand5 *= iSync
    
    kRand6 random 0, 1
    kRand6 *= iSync

    ;Create envelopes
    aEnv1 madsr iOscAtk, iOscDec, iOscSus, iOscRel
    aEnv2 madsr iModAtk, iModDec, iModSus, iModRel
    
    ;Check if oscillator mode or voice setting has been changed. 
    ;Reinitialize the oscillator upon change to prevent it from hanging onto previous iModes.
    kChange changed kEnableFM, kEnableSin, kEnableTri, kEnableSqr, kEnableSaw, kVoices
    if kChange = 1 then
        reinit INIT_OSC
    endif
    
    ;Check and change oscillator mode. Fit everything into one variable to keep things organized.
    ;OSCILLATOR MODULE
    INIT_OSC:
    if i(kEnableFM) == 1 then
        iOscMode = 0
        cabbageSet "ModAttack", "alpha", 1
        cabbageSet "ModDecay", "alpha", 1
        cabbageSet "ModSustain", "alpha", 1
        cabbageSet "ModRelease", "alpha", 1
    elseif i(kEnableSin) == 1 then
        iOscMode = 1
        cabbageSet "ModAttack", "alpha", 0.5
        cabbageSet "ModDecay", "alpha", 0.5
        cabbageSet "ModSustain", "alpha", 0.5
        cabbageSet "ModRelease", "alpha", 0.5
    elseif i(kEnableTri) == 1 then
        iOscMode = 2
        cabbageSet "ModAttack", "alpha", 0.5
        cabbageSet "ModDecay", "alpha", 0.5
        cabbageSet "ModSustain", "alpha", 0.5
        cabbageSet "ModRelease", "alpha", 0.5
    elseif i(kEnableSqr) == 1 then
        iOscMode = 3
        cabbageSet "ModAttack", "alpha", 0.5
        cabbageSet "ModDecay", "alpha", 0.5
        cabbageSet "ModSustain", "alpha", 0.5
        cabbageSet "ModRelease", "alpha", 0.5
    elseif i(kEnableSaw) == 1 then
        iOscMode = 4
        cabbageSet "ModAttack", "alpha", 0.5
        cabbageSet "ModDecay", "alpha", 0.5
        cabbageSet "ModSustain", "alpha", 0.5
        cabbageSet "ModRelease", "alpha", 0.5
    else
        prints "Invalid value for oscilator waveform type (None enabled) \n"
    endif
    
    iAmp = p5
    kCps = p4
    kCps *= kFineTune
    kCps *= kVib
    
    ;Scale output to voices enabled for consistent loudness.
    iScale = 1/i(kVoices)
    iScale *= 0.8 ;reduce clipping
    
    ;Configure panning based on voice setting
    if i(kVoices) == 1 then
        iPan1 = 0.5
    elseif i(kVoices) == 2 then
        iPan1 = 0
        iPan2 = 1
    elseif i(kVoices) == 3 then
        iPan1 = 0
        iPan2 = 1
        iPan3 = 0.5
    elseif i(kVoices) == 4 then
        iPan1 = 0
        iPan2 = 1
        iPan3 = 0.25
        iPan4 = 0.75
    elseif i(kVoices) == 5 then
        iPan1 = 0 
        iPan2 = 1
        iPan3 = 0.75
        iPan4 = 0.25
        iPan5 = 0.5
    elseif i(kVoices) == 6 then
        iPan1 = 0 
        iPan2 = 1
        iPan3 = 0.8
        iPan4 = 0.2
        iPan5 = 0.4
        iPan6 = 0.6
    else ;failsafe
        iPan1 = 0.5
        iPan2 = 0.5
        iPan3 = 0.5
        iPan4 = 0.5
        iPan5 = 0.5
        iPan6 = 0.5
    endif
    
    ;Use the "generator" UDO to easily generate a sound.
    ;Check voice amount and generate oscillators accordingly.
    ;Finally, apply pan to the signal
    if kVoices >= 1 then
        aOsc1 generator iAmp, kCps*kDetuneUp1, kModFreq, aEnv2, iOscMode, i(kRand1), \ 
        iMin3, i3rd, i4th, i5th, iMin6, i6th, i7th, iMaj7, iOct, kHarmAmp
        aOsc1 *= iScale
        aOsc1L, aOsc1R pan2 aOsc1, iPan1
    endif
    
    if kVoices >= 2 then
        aOsc2 generator iAmp, kCps*kDetuneDown1, kModFreq, aEnv2, iOscMode, i(kRand2), \ 
        iMin3, i3rd, i4th, i5th, iMin6, i6th, i7th, iMaj7, iOct, kHarmAmp
        aOsc2 *= iScale
        aOsc2L, aOsc2R pan2 aOsc2, iPan2
    else
        aOsc2L = 0
        aOsc2R = 0
    endif
    
    if kVoices >= 3 then
        aOsc3 generator iAmp, kCps*kDetuneUp2, kModFreq, aEnv2, iOscMode, i(kRand3), \ 
        iMin3, i3rd, i4th, i5th, iMin6, i6th, i7th, iMaj7, iOct, kHarmAmp
        aOsc3 *= iScale
        aOsc3L, aOsc3R pan2 aOsc3, iPan3
    else
        aOsc3L = 0
        aOsc3R = 0
    endif
    
    if kVoices >= 4 then
        aOsc4 generator iAmp, kCps*kDetuneDown2, kModFreq, aEnv2, iOscMode, i(kRand4), \ 
        iMin3, i3rd, i4th, i5th, iMin6, i6th, i7th, iMaj7, iOct, kHarmAmp
        aOsc4 *= iScale
        aOsc4L, aOsc4R pan2 aOsc4, iPan4
    else
        aOsc4L = 0
        aOsc4R = 0
    endif
    
    if kVoices >= 5 then
        aOsc5 generator iAmp, kCps*kDetuneUp3, kModFreq, aEnv2, iOscMode, i(kRand5), \ 
        iMin3, i3rd, i4th, i5th, iMin6, i6th, i7th, iMaj7, iOct, kHarmAmp
        aOsc5 *= iScale
        aOsc5L, aOsc5R pan2 aOsc5, iPan5
    else
        aOsc5L = 0
        aOsc5R = 0
    endif
    
    if kVoices >= 6 then
        aOsc6 generator iAmp, kCps*kDetuneDown3, kModFreq, aEnv2, iOscMode, i(kRand6), \ 
        iMin3, i3rd, i4th, i5th, iMin6, i6th, i7th, iMaj7, iOct, kHarmAmp
        aOsc6 *= iScale
        aOsc6L, aOsc6R pan2 aOsc6, iPan6
    else
        aOsc6L = 0
        aOsc6R = 0
    endif
    
    
    ;Add all oscillators to a single output.
    aOscL = aOsc1L+aOsc2L+aOsc3L+aOsc4L+aOsc5L+aOsc6L
    aOscR = aOsc1R+aOsc2R+aOsc3R+aOsc4R+aOsc5R+aOsc6R
    
    aOscL *= aEnv1
    aOscR *= aEnv1
    
    kEnableSynth cabbageGetValue "enableSynth"
    if kEnableSynth == 0 then
        aOscL = 0
        aOscR = 0
    endif
    
    aOutL = aOscL
    aOutR = aOscR
    
    ;Check if noise is enabled
    kEnableNoise cabbageGetValue "enableNoise"
    
    ;Check noise type
    kNoiseType cabbageGetValue "NoiseType"
    
    ;Get ADSR controls for Noise 
    iNAtk cabbageGetValue "NoiseAtk"
    iNDec cabbageGetValue "NoiseDec"
    iNSus cabbageGetValue "NoiseSus"
    iNRel cabbageGetValue "NoiseRel"
    
    ;Get filter type and controls
    kNFilterType cabbageGetValue "NoiseFilterType"
    kNCutFreq cabbageGetValue "NoiseFilterFreq"
    kNQ cabbageGetValue "NoiseFilterQ"
    
    ;Create envelope
    aNoiseEnv madsr iNAtk, iNDec, iNSus, iNRel
    
    ;Check for changes to noise type, and reinit module.
    kNoiseChange changed kNoiseType
    if kNoiseChange = 1 then
        reinit INIT_NOISE
    endif
    
    ;NOISE GENERATOR
    INIT_NOISE:
    
    if kNoiseType = 0 then ;White Noise
        aNoiseL rand, iAmp, 2
        aNoiseR rand, iAmp, 3
    elseif kNoiseType = 1 then ;Pink Noise
        aNoiseL pinkish iAmp
        aNoiseR pinkish iAmp
    else
        aNoiseL = 0
        aNoiseR = 0
    endif
    
    aNoiseL *= aNoiseEnv
    aNoiseR *= aNoiseEnv
    aNoiseL *= 0.25
    aNoiseR *= 0.25
    
    ;Apply filter to the noise signal
    aLowL, aHighL, aBandL svfilter aNoiseL, kNCutFreq, kNQ, 0.5
    aLowR, aHighR, aBandR svfilter aNoiseR, kNCutFreq, kNQ, 0.5
    
    if kNFilterType = 0 then ;Bypass Filter
        aNoiseOutL = aNoiseL
        aNoiseOutR = aNoiseR
    elseif kNFilterType = 1 then ;Highpass filter
        aNoiseOutL = aHighL
        aNoiseOutR = aHighR
    elseif kNFilterType = 2 then ;Bandpass Filter
        aNoiseOutL = aBandL
        aNoiseOutR = aBandR
    elseif kNFilterType = 3 then ;Lowpass filter
        aNoiseOutL = aLowL
        aNoiseOutR = aLowR
    endif
    
    if kEnableNoise == 1 then
        aOutL += aNoiseOutL
        aOutR += aNoiseOutR
    else
        aOutL = aOutL
        aOutR = aOutR
    endif
    
    ;ENVELOPE CONTROLLED FILTER
    
    ;Get ADSR controls for filter
    iFilterAtk cabbageGetValue "preFilterAtk"
    iFilterDec cabbageGetValue "preFilterDec"
    iFilterAmp cabbageGetValue "preFilterAmp"
    
    ;Get filter type and controls
    kFilterType cabbageGetValue "preFilterType"
    kCfControl cabbageGetValue "preFilterCut"
    kQ cabbageGetValue "preFilterQ"
    
    ;Create envelope
    kFilterEnv madsr iFilterAtk, iFilterDec, 0, iOscRel
    kCutFreq = kCfControl*((kFilterEnv*iFilterAmp)+1)
    
    if kCutFreq > 15000 then
        kCutFreq = 15000
    else
        kCutFreq = kCutFreq
    endif
    
    ;Apply filter to the noise signal
    aLowL, aHighL, aBandL svfilter aOutL, kCutFreq, kQ
    aLowR, aHighR, aBandR svfilter aOutR, kCutFreq, kQ
    
    ;I never figured out why, but this opcode makes Csound crash when the Cutoff Freq is high (i.e. 10 000) and the Q factor is low (i.e. 4)
    ;After some troubleshooting, I found out that this specific combination makes the sample values get absurdly high and cause what looks like memory overflow.
    ;When that happens, aFilterL and aFilterR simply returns the "-nan(ind)" which causes audio output to stop working entirely.
    
    if kFilterType = 0 then ;Bypass Filter
        aFilterL = aOutL
        aFilterR = aOutR
    elseif kFilterType = 1 then ;Highpass filter
        aFilterL balance aHighL, aOutL
        aFilterR balance aHighR, aOutR
    elseif kFilterType = 2 then ;Bandpass Filter
        aFilterL balance aBandL, aOutL
        aFilterR balance aBandR, aOutR
    elseif kFilterType = 3 then ;Lowpass filter
        aFilterL balance aLowL, aOutL
        aFilterR balance aLowR, aOutR
    endif
    
    gaOscL += aFilterL
    gaOscR += aFilterR
    
endin

;PVS Effects Module
instr 30
    kEnableFreeze cabbageGetValue "Freeze"
    kEnableBlur cabbageGetValue "Blur"
    kQualityControl cabbageGetValue "fftQuality"
    kBlurControl cabbageGetValue "fftSmooth"
    
    ;Invert scaling for UI purposes
    kBlurAmount scale2 kBlurControl, 0.999, 0.001, 0, 1

    ;Get input from the Oscillator and Noise modules
    aL = gaOscL
    aR = gaOscR
    
    kChange changed kQualityControl
    if kChange == 1 then
        reinit INIT_FFT
    endif
    
    INIT_FFT:
    ;FFT analysis parameters
    if kQualityControl == 1 then
        iQuality = 128
    elseif kQualityControl == 2 then
        iQuality = 256
    elseif kQualityControl == 3 then
        iQuality = 512
    elseif kQualityControl == 4 then
        iQuality = 1024
    elseif kQualityControl == 5 then
        iQuality = 2048
    elseif kQualityControl == 6 then
        iQuality = 4096
    elseif kQualityControl == 7 then
        iQuality = 8192
    elseif kQualityControl == 8 then
        iQuality = 16384
    else
        iQuality = 1024 ;failsafe
    endif
    
    iOverlap = iQuality / 4
    iSize = iQuality * 2
    iType = 0
    
    fAnalyzeL pvsanal aL, iQuality, iOverlap, iSize, iType
    fAnalyzeR pvsanal aR, iQuality, iOverlap, iSize, iType
    
    fBlurL pvsmooth fAnalyzeL, kBlurAmount, kBlurAmount
    fBlurR pvsmooth fAnalyzeR, kBlurAmount, kBlurAmount
    
    if kEnableBlur == 1 then
        fFreezeL pvsfreeze fBlurL, kEnableFreeze, kEnableFreeze
        fFreezeR pvsfreeze fBlurR, kEnableFreeze, kEnableFreeze
    else
        fFreezeL pvsfreeze fAnalyzeL, kEnableFreeze, kEnableFreeze
        fFreezeR pvsfreeze fAnalyzeR, kEnableFreeze, kEnableFreeze
    endif
    
    aOutL pvsynth fFreezeL
    aOutR pvsynth fFreezeR
    
    gaBlizzL += aOutL
    gaBlizzR += aOutR
    
endin

instr 100
    aMasterL = gaBlizzL
    aMasterR = gaBlizzR
    
    outs aMasterL, aMasterR
    
    gaOscL = 0
    gaOscR = 0
    
    gaBlizzL = 0
    gaBlizzR = 0
    
    aMasterL = 0
    aMasterR = 0
endin
</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
;f0 z
i1 0 z
i30 0 z
i100 0 z
</CsScore>
</CsoundSynthesizer>
