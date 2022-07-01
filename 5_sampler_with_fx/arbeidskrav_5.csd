<CsoundSynthesizer>
<CsOptions>
-odac0 -M0 -b16 -B2056 -v
</CsOptions>
<CsInstruments>
;Code was written to be performed on an AKAI MPD226, using one of the Generic presets.

sr = 44100
ksmps = 10
nchnls = 2
0dbfs = 1

;Load samples into tables using GEN01 routine
giAmen ftgen 1, 0, 0, 1, "amenbreak_170.wav", 0, 0, 0
giOrch ftgen 2, 0, 0, 1, "hiphophit.wav", 0, 0, 0
giSynth ftgen 3, 0, 0, 1, "synthstab.wav", 0, 0, 0

;Initialize all CC values
initc7 1, 3, 0 
initc7 1, 9, 1
initc7 1, 14, 0.2

initc7 1, 52, 0
initc7 1, 53, 1
initc7 1, 54, 0.2

initc7 1, 83, 0
initc7 1, 85, 1
initc7 1, 86, 0.2

initc7 1, 61, 0.5
initc7 1, 62, 0.5
initc7 1, 63, 0.5

initc7 1, 20, 1
initc7 1, 21, 0
initc7 1, 22, 0
initc7 1, 23, 0.5

;Initialize global audio variables
gaSamplerL init 0
gaSamplerR init 0

gaFlangerL init 0
gaFlangerR init 0

gaReverbL init 0
gaReverbR init 0

gaMasterL init 0
gaMasterR init 0

instr Sampler
    ;Get MIDI note number and amplitude
    iNote notnum
    iAmp ampmidi 1

    ;Simple ADSR
    aEnv madsr 0.01, 0.01, 1, 0.01

    ;Setup controllers for sample start, sample end and sample tuning.
    ;Sample rate divided by table length = table length in seconds. Limit the start time to prevent overflow.
    iSmplLength1 = ftlen(giAmen)/sr
    iSmplStart1 ctrl7 1, 3, 0, iSmplLength1-0.01
    kLoopStart1 ctrl7 1, 3, 0, iSmplLength1-0.01
    kLoopEnd1   ctrl7 1, 9, 0, iSmplLength1
    kSmplTune1  ctrl7 1, 14, 0.25, 4

    iSmplLength2 = ftlen(giOrch)/sr
    iSmplStart2 ctrl7 1, 52, 0, iSmplLength2-0.01
    kLoopStart2 ctrl7 1, 52, 0, iSmplLength2-0.01
    kLoopEnd2   ctrl7 1, 53, 0, iSmplLength2
    kSmplTune2  ctrl7 1, 54, 0.25, 4

    iSmplLength3 = ftlen(giSynth)/sr
    iSmplStart3 ctrl7 1, 83, 0, iSmplLength3-0.01
    kLoopStart3 ctrl7 1, 83, 0, iSmplLength3-0.01
    kLoopEnd3   ctrl7 1, 85, 0, iSmplLength3
    kSmplTune3  ctrl7 1, 86, 0.25, 4

    ;Jump to code based on which pad is hit
    if iNote = 36 goto amen
    if iNote = 37 goto orch
    if iNote = 38 goto synth

    amen:
        ;Failsafe for when the loop end is before the sample start.
        if kLoopEnd1 <= kLoopStart1 then
            kLoopEnd1 = kLoopStart1+0.01
        else
            kLoopEnd1 = kLoopEnd1
        endif

        ;Sample looper opcode
        aOutL, aOutR flooper2 iAmp, kSmplTune1, kLoopStart1, kLoopEnd1, 0.01, giAmen, iSmplStart1
        goto output
    
    orch:
        if kLoopEnd2 <= kLoopStart2 then
            kLoopEnd2 = kLoopStart2+0.01
        else
            kLoopEnd2 = kLoopEnd2
        endif

        aOutL, aOutR flooper2 iAmp, kSmplTune2, kLoopStart2, kLoopEnd2, 0.01, giOrch, iSmplStart2
        goto output

    synth:
        if kLoopEnd3 <= kLoopStart3 then
            kLoopEnd3 = kLoopStart3+0.01
        else
            kLoopEnd3 = kLoopEnd3
        endif

        aOutL, aOutR flooper2 iAmp, kSmplTune3, kLoopStart3, kLoopEnd3, 0.01, giSynth, iSmplStart3
        goto output

    output:
        aOutL *= aEnv
        aOutR *= aEnv

        gaSamplerL = aOutL
        gaSamplerR = aOutR
endin

instr Flanger
    aInputL = gaSamplerL
    aInputR = gaSamplerR

    kFeedbk ctrl7 1, 61, 0.1, 0.9
    aDelay = 0.0025
    aLFO lfo 0.002, 0.5

    aDelay += aLFO 

    aOutL flanger aInputL, aDelay, kFeedbk
    aOutR flanger aInputR, aDelay, kFeedbk

    gaFlangerL += aOutL
    gaFlangerR += aOutR
endin

instr Reverb
    aInputL = gaSamplerL
    aInputR = gaSamplerR

    kFeedbk ctrl7 1, 62, 0.01, 0.99
    kCutFreq ctrl7 1, 63, 100, 8000

    aOutL, aOutR reverbsc aInputL, aInputR, kFeedbk, kCutFreq

    gaReverbL += aOutL
    gaReverbR += aOutR
endin

instr Master
    kSamplerMix ctrl7 1, 20, 0, 1
    gaSamplerL *= kSamplerMix
    gaSamplerR *= kSamplerMix

    kFlangerMix ctrl7 1, 21, 0, 1
    gaFlangerL *= kFlangerMix
    gaFlangerR *= kFlangerMix

    kReverbMix ctrl7 1, 22, 0, 1
    gaReverbL *= kReverbMix
    gaReverbR *= kReverbMix

    kMasterLvl ctrl7 1, 23, 0, 1

    ;Sum everything to master output
    gaMasterL = gaMasterL+(gaSamplerL+gaFlangerL+gaReverbL)
    gaMasterR = gaMasterR+(gaSamplerR+gaFlangerR+gaReverbR)

    outs gaMasterL*kMasterLvl, gaMasterR*kMasterLvl
    fout "arbeidskrav_5.wav", 14, gaMasterL*kMasterLvl, gaMasterR*kMasterLvl

    ;Prevent feedback
    gaSamplerL = 0
    gaSamplerR = 0

    gaFlangerL = 0
    gaFlangerR = 0

    gaReverbL = 0
    gaReverbR = 0

    gaMasterL = 0
    gaMasterR = 0
endin
</CsInstruments>

<CsScore>
i"Flanger" 0 60
i"Reverb" 0 60
i"Master" 0 60

</CsScore>
</CsoundSynthesizer>