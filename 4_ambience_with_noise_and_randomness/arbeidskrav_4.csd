<CsoundSynthesizer>

<CsOptions>
-odac0 -M0 -b16 -B2056
</CsOptions>

<CsInstruments>
sr = 44100
nchnls = 2
0dbfs = 1

;Use system clock for random seed
seed 0

gaDryL init 0
gaDryR init 0
gaMasterL init 0
gaMasterR init 0

initc7 1, 0, 0
initc7 1, 36, 1
initc7 2, 1, 0
initc7 2, 37, 0
initc7 3, 2, 0.5
initc7 3, 38, 0
initc7 4, 3, 1

;Table with the MIDI note values of a Cm9 chord
giNotes ftgen 0, 0, 10, -2, 60, 62, 63, 67, 70, 60+12, 62+12, 63+12, 67+12, 70+12

;Create a wave with hammond B3 harmonics
giHarmonics ftgen 0, 0, 4096, 10, 1, 1/2, 1/3, 1/4, 1/6, 1/8, 1/10, 1/12, 1/16

;MIDI controlled howling wind
instr 1
    ;Control the cutoff frequency (wind tone) with MIDI CC
    kCutFreq ctrl7 1, 0, 100, 10000
    kReso ctrl7 1, 36, 0, 1

    aEnv madsr 1, 3, 1, 1

    ;Simple noise generator
    aNoise rand 1

    ;Apply filter to noise, high resonance creates a "howling" wind sound
    aFilter moogladder aNoise, kCutFreq, kReso
    aFilter *= aEnv

    ;Output signal to master channel
    gaMasterL += aFilter*0.2
    gaMasterR += aFilter*0.2
endin

;MIDI controlled crashing waves
instr 2
    ;Control cutoff frequency with MIDI CC
    kCutFreq ctrl7 2, 1, 100, 10000
    kReso ctrl7 2, 37, 0, 1

    ;Fast ramp up and slow ramp down creates the sound of a crashing wave.
    aEnv madsr 1, 2, 0, 2

    ;Noise generator
    aNoise rand 1
    aNoise *= aEnv

    ;Apply filter to noise
    aFilter moogladder aNoise, kCutFreq, kReso

    ;Output signal to master
    gaMasterL += aFilter*0.2
    gaMasterR += aFilter*0.2
endin

;Random tone generator
instr 3

    ;Control rate and tone limit with MIDI CC
    kRandRate ctrl7 3, 2, 1, 16
    kRandLimit ctrl7 4, 3, 0, 10.99
    kRandNum randomh 0, kRandLimit, kRandRate

    ;Lookup values from function table, then convert to frequency.
    kMidiNote table kRandNum, giNotes
    kCps mtof kMidiNote

    ;Random panning
    kAmpL randomh 0.1, 1, kRandRate
    kAmpR randomh 0.1, 1, kRandRate

    ;Control release envelope with MIDI CC
    iRelease ctrl7 3, 38, 0.01, 2
    aEnv madsr 0.05, 0.01, 1, iRelease

    ;Simple oscillator using an organ waveform
    aOsc oscil 0.1, kCps, giHarmonics
    aOsc *= aEnv

    ;Apply random panning
    aPanL = aOsc*kAmpL
    aPanR = aOsc*kAmpR

    ;Dry signal to effect
    gaDryL += aPanL
    gaDryR += aPanR

    ;Dry signal to master
    gaMasterL += aPanL*0.5
    gaMasterR += aPanR*0.5
endin

;Drone synth
instr 4
    iCps = 40

    ;Setting up a unipolar LFO for modulating the cutoff freq.
    kLFO1 lfo 0.5, 0.1
    kLFO1 += 1
    kCutOff = 500*kLFO1

    aEnv madsr 2, 0.01, 1, 1

    ;Sawtooh fundamental
    aOsc1 vco2 0.2, iCps-2, 4, 0.01, 0
    aOsc1 *= aEnv

    ;Slow and minor pitch vibrato, move up an octave
    kLFO2 lfo 0.02, 0.2
    kLFO2 += -1
    kModPitch = (iCps*2)*kLFO2

    ;Detuned saw
    aOsc2 vco2 0.1, kModPitch, 4, 0.1, 0.2
    aOsc2 *= aEnv

    aMix = aOsc1 + aOsc2

    ;Add filter to the mixed signal
    aFilter moogladder aMix, kCutOff, 0.1

    ;Send signal to master
    gaMasterL += aFilter*0.75
    gaMasterR += aFilter*0.75
endin

;Reverb Effect
instr 10
    ;Room size and reverb cutoff frequency
    iRoom = 0.95
    iCutOff = 3000

    ;Reverberate input signal
    aCombL comb gaDryL, 2, 0.1
    aCombR comb gaDryR, 2, 0.1

    ;8 delay line FDN stereo reverb
    aReverbL, aReverbR reverbsc aCombL, aCombR, iRoom, iCutOff

    ;Mix reverb into master signal
    gaMasterL += aReverbL*0.25
    gaMasterR += aReverbR*0.25

    ;Init to avoid feedback
    gaDryL = 0
    gaDryR = 0
endin

instr 20
    ;Output to speakers, and write audio to disk.
    outs gaMasterL, gaMasterR
    fout "arbeidskrav_4.wav", 14, gaMasterL, gaMasterR

    ;Init to avoid feedback
    gaMasterL = 0
    gaMasterR = 0
endin
</CsInstruments>

<CsScore>
i4  0 90
i10 0 90
i20 0 90
</CsScore>

</CsoundSynthesizer>