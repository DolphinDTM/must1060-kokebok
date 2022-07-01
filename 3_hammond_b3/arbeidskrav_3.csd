<CsoundSynthesizer>

<CsOptions>
-odac0 -M0 -b16 -B2056
</CsOptions>

<CsInstruments>

sr = 44100
0dbfs = 1
nchnls = 2

;Generate function tables with GEN10
giTable1 ftgen 0, 0, 4096, 10, 1, 1/2, 1/3, 1/4, 1/6, 1/8, 1/10, 1/12, 1/16
giTable2 ftgen 0, 0, 4096, 10, 0, 0, 0, 0, 0, 0, 1/10, 1/12, 1/16
giTable3 ftgen 0, 0, 4096, 10, 1, 1/2, 1/3, 1/4, 0, 0, 0, 0, 1/16
giTable4 ftgen 0, 0, 4096, 10, 1, 1/2, 1/3, 0, 0, 0, 1/10, 1/12, 1/16
giTable5 ftgen 0, 0, 4096, 10, 1, 0, 0, 0, 0, 0, 1/10, 0, 1/16
giTable6 ftgen 0, 0, 4096, 10, 0, 1/2, 0, 1/4, 0, 1/8, 0, 1/12, 0

;Init CC
initc7 1, 1, 0.15
initc7 1, 14, 1
initc7 1, 15, 1
initc7 1, 16, 0
initc7 1, 17, 0
initc7 1, 21, 0

;Init global variables
gaMasterL init 0
gaMasterR init 0
gaSendL init 0
gaSendR init 0

;MIDI Controlled instrument
instr 1
    ;Common variables
    iTable ctrl7 1, 21, 101, 106 ;Get function table from MIDI CC
    kCps cpsmidib 2
    iAmp ampmidi 0.1
    aEnv madsr 0.01, 0.01, 1, 0.01

    ;Control oscillator volume
    kVol1 ctrl7 1, 14, 0, 1
    kVol2 ctrl7 1, 15, 0, 1

    ;Unmodulated tone
    aOut oscil iAmp, kCps, iTable
    aOut *= aEnv

    ;Vibrato settings
    kVibAmp ctrl7 1, 1, 0, 0.1
    kVibRate = 6 ;Fixed to 6Hz

    ;Setting up the vibrato LFO
    kVib lfo kVibAmp, kVibRate
    kFreq = kCps+kVib

    ;Scale vibrato to tone
    kVibScaled = kVibAmp*kCps
    kVib2 oscil kVibScaled, kVibRate
    kVib2 = kCps+kVib2
    
    ;Modulated tone
    aOut2 oscil iAmp, kVib2, iTable
    aOut2 *= aEnv

    ;Scale output volume
    aScaled1 = aOut*kVol1
    aScaled2 = aOut2*kVol2

    ;Create a mixdown of the two outputs
    aMix = aScaled1+aScaled2

    ;Create master outputs
    gaMasterL += aMix
    gaMasterR += aMix

    ;Create sends to the reverb effect
    gaSendL += aMix
    gaSendR += aMix
endin

;Reverb Effect
instr 2
    ;Variables controleld by MIDI CC
    kRoom ctrl7 1, 16, 0.01, 0.99
    kCutOff ctrl7 1, 17, 100, 10000

    ;Reverberate input signal
    aCombL comb gaSendL, 2, 0.1
    aCombR comb gaSendR, 2, 0.2

    ;8 delay line FDN stereo reverb
    aReverbL, aReverbR reverbsc aCombL, aCombR, kRoom, kCutOff

    ;Mix reverb into master signal
    gaMasterL += aReverbL
    gaMasterR += aReverbR

    ;Init to avoid feedback
    gaSendL = 0
    gaSendR = 0
endin

instr 3
    ;Output to speakers, and write audio to disk.
    outs gaMasterL, gaMasterR
    fout "arbeidskrav_3.wav", 14, gaMasterL, gaMasterR

    ;Init to avoid feedback
    gaMasterL = 0
    gaMasterR = 0
endin


</CsInstruments>

<CsScore>
i2 0 60
i3 0 60
</CsScore>

</CsoundSynthesizer>