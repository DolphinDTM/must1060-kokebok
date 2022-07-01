<CsoundSynthesizer>

<CsOptions>
-odac -iadc
-b32 -B2056
;-t60 ;(this must be uncommented if you are not reading score from a MIDI file.)
-Ma
-F 3_score.mid
</CsOptions>

<CsInstruments>

;Global Values
;------------------------------------------------------------
0dbfs = 1
sr = 44100
ksmps = 1
nchnls = 2
seed 0

;User Defined Opcodes (UDO)
;------------------------------------------------------------

;Simple chorus effect.
opcode chorus, aa, aakk
  aL, aR, kFreq, kDepth xin

  ;LFO modulates the delay time.
  aLFO lfo kDepth, kFreq
  aLFO += kDepth ;polarisering

  ;variable delay. add an extra 25ms of delay
  aOutL vdelay aL, aLFO+25, 100
  aOutR vdelay aR, aLFO+25, 100

  xout aOutL, aOutR
endop

;Stereo Vocoder
opcode vocoders, aa, aaai
  aMod, aCarL, aCarR, iFFT xin

  ;FFT analysis of all input signals
  fModAnalyze pvsanal aMod, iFFT, iFFT/4, iFFT*2, 1
  fCarLAnalyze pvsanal aCarL, iFFT, iFFT/4, iFFT*2, 1
  fCarRAnalyze pvsanal aCarR, iFFT, iFFT/4, iFFT*2, 1

  ;Get the amplitude from the modulator, and run it through the frequencies of the carrier.
  fVocL pvsvoc fModAnalyze, fCarLAnalyze, 1, 1
  fVocR pvsvoc fModAnalyze, fCarRAnalyze, 1, 1

  ;Resynthesize
  aOutL pvsynth fVocL
  aOutR pvsynth fVocR

  xout aOutL, aOutR
endop

;Global Variables
;------------------------------------------------------------

;Make it possible to swap between square and sawtooth waveforms.
giWaveform ftgen 0, 0, 0, -2, 0, 10
;Load audio sample into function table.
giAmen ftgen 0, 0, 0, 1, "amenbreak.wav", 0, 0, 1
;Hammond-like waveform
giHammond ftgen 0, 0, 4096, 10, 1, 1/2, 1/3, 1/4, 1/6, 1/8, 1/10, 1/12, 1/16
;Default BPM to 60
gkBPM init 60
;Initialize the variable used for glide.
gkOldCps init 0

giScale = 1/5

;MIDI Controllers
;------------------------------------------------------------
massign 1, "Detune"
massign 2, "Sampler"
massign 3, "Harmonizer"
massign 4, "Detune2"
massign 5, "ArpSynth"
massign 6, "Metronome"

;Global definitions for CC makes it easier to change CC numbers
;in the case you want to change MIDI controllers.

giKeysChn     = 1   ;MIDI channel for keyboard
giPadsChn     = 2   ;MIDI channel for pad
giCtrlChn     = 3   ;MIDI channel for control surface

;Synth Params
giVibCC       = 1   ;Vibrato/Tremolo Depth
giDetCC       = 14  ;Detune
giWaveCC      = 74  ;Waveform

;Modwheel Toggle
giVibOnCC     = 73  ;Enable Vibrato
giTremOnCC    = 72  ;Enable Tremolo

;Synth ADSR
giAtkCC       = 61  ;Attack
giDecCC       = 62  ;Decay
giSusCC       = 63  ;Sustain
giRelCC       = 70  ;Release

;Synth Filter
giLPSynthCC   = 0   ;Cutoff Frequency
giLPAmpCC     = 36  ;Filter Envelope Amplitude
giLPAtkCC     = 52  ;Filter Envelope Attack
giLPDecCC     = 53  ;Filter Envelope Decay

;Multieffect
giChoFreqCC   = 15  ;Chorus Frequency
giChoDeptCC   = 16  ;Chorus Depth
giRevFdbkCC   = 17  ;Reverb Feedback Level
giRevCutCC    = 18  ;Reverb Cutoff Frequency

;Multieffect Mix
giChoMixCC    = 37  ;Chorus Mix
giRevMixCC    = 38  ;Reverb Mix
giShimMixCC   = 39  ;Shimmer Mix

;Breakbeat Effects
giBrkCutCC    = 3   ;Breakbeat Filter Cutoff
giBrkResCC    = 20  ;Breakbeat Filter Resonance
giBrkRevFbkCC = 9   ;Breakbeat Reverb Feedback Level
giBrkRevMixCC = 21  ;Breakbeat Reverb Mix Level

;Freeze Controls
giFreezeCC    = 28  ;Enable Freeze
giLPFreezeCC  = 15  ;Freeze Lowpass Filter

;Trigger Controls
giTrig16CC    = 29  ;Enable 16th Retrigger
giTrig24CC    = 30  ;Enable 16th Triplet Retrigger
giTrig32CC    = 31  ;Enable 32nd Retrigger

;Arpeggio Controls
giArpRateCC   = 20  ;Arpeggio Rate
giLPArpCC     = 21  ;Arpeggio Filter

;Initialization of controls
initc7 giKeysChn, giVibCC,       0
initc7 giKeysChn, giDetCC,       0
initc7 giCtrlChn, giWaveCC,      0

initc7 giCtrlChn, giVibOnCC,     0
initc7 giCtrlChn, giTremOnCC,    0

initc7 giPadsChn, giAtkCC,       0
initc7 giPadsChn, giDecCC,       0
initc7 giPadsChn, giSusCC,       1
initc7 giPadsChn, giRelCC,       0

initc7 giCtrlChn, giLPSynthCC,   1
initc7 giCtrlChn, giLPAmpCC,     0
initc7 giPadsChn, giLPAtkCC,     0.1
initc7 giPadsChn, giLPDecCC,     0.1

initc7 giKeysChn, giChoFreqCC,   0
initc7 giKeysChn, giChoDeptCC,   0
initc7 giKeysChn, giRevFdbkCC,   0.8
initc7 giKeysChn, giRevCutCC,    1

initc7 giCtrlChn, giChoMixCC,    1
initc7 giCtrlChn, giRevMixCC,    0.5
initc7 giCtrlChn, giShimMixCC,   1

initc7 giPadsChn, giBrkCutCC,    1
initc7 giPadsChn, giBrkResCC,    0.5
initc7 giPadsChn, giBrkRevFbkCC, 0.5
initc7 giPadsChn, giBrkRevMixCC, 0.25

initc7 giPadsChn, giFreezeCC,    0
initc7 giPadsChn, giLPFreezeCC,  1

initc7 giKeysChn, giArpRateCC,   0.5
initc7 giKeysChn, giLPArpCC,     1

;Signal Routing
;------------------------------------------------------------

connect "Detune",     "OutLeft",  "MultiFX",     "InLeft"
connect "Detune",     "OutRight", "MultiFX",     "InRight"

connect "Detune",     "OutLeft",  "Freeze",      "InLeft"
connect "Detune",     "OutRight", "Freeze",      "InRight"

connect "Detune2",    "OutLeft",  "Vocoder",     "CarrierLeft"
connect "Detune2",    "OutRight", "Vocoder",     "CarrierRight"

connect "ArpSynth",   "Output",   "Freeze",      "InLeft"
connect "ArpSynth",   "Output",   "Freeze",      "InRight"

connect "ArpSynth",   "Output",   "ArpReverb",   "InLeft"
connect "ArpSynth",   "Output",   "ArpReverb",   "InRight"

connect "ArpReverb",  "OutLeft",  "Freeze",      "InLeft"
connect "ArpReverb",  "OutRight", "Freeze",      "InRight"

connect "AmenBreak",  "OutLeft",  "Freeze",      "InLeft"
connect "AmenBreak",  "OutRight", "Freeze",      "InRight"

connect "AmenBreak",  "OutLeft",  "BreakVerb",   "InLeft"
connect "AmenBreak",  "OutRight", "BreakVerb",   "InRight"

connect "BreakVerb",  "OutLeft",  "Freeze",      "InLeft"
connect "BreakVerb",  "OutRight", "Freeze",      "InRight"

connect "Microphone", "Output",   "Vocoder",     "Modulator"

connect "Microphone", "Output",   "Harmonizer",  "Input"

connect "Vocoder",    "OutLeft",  "Freeze",      "InLeft"
connect "Vocoder",    "OutRight", "Freeze",      "InRight"

connect "Vocoder",    "OutLeft",  "MultiFX",     "InLeft"
connect "Vocoder",    "OutRight", "MultiFX",     "InRight"

connect "Harmonizer", "Output",   "Freeze",      "InLeft"
connect "Harmonizer", "Output",   "Freeze",      "InRight"

connect "MultiFX",    "OutLeft",  "Freeze",      "InLeft"
connect "MultiFX",    "OutRight", "Freeze",      "InRight"

connect "Freeze",     "OutLeft",  "Master",      "InLeft"
connect "Freeze",     "OutRight", "Master",      "InRight"

alwayson "Microphone"
alwayson "MultiFX"
alwayson "BreakVerb"
alwayson "ArpReverb"
alwayson "Vocoder"
alwayson "Freeze"
alwayson "Master"

;Instrument Definitions
;------------------------------------------------------------

instr Detune
  /**************************************

  DELOPPGAVE 1 - MIDI-styrt instrument

  **************************************/

  ;Get amplitude and pitch from MIDI
  iAmp ampmidi 1
  kCps cpsmidib 2

  ;Add MIDI CC control
  kGetWave    ctrl7 giCtrlChn, giWaveCC, 0, 1.99
  kDetuneCtrl ctrl7 giKeysChn, giDetCC, 0, 2

  ;Get iMode value from table
  kChangeMode table kGetWave, giWaveform

  ;Simple LFO
  kVibAmount  ctrl7 giKeysChn, giVibCC, 0, 0.1
  kVib lfo kVibAmount, 6

  ;Toggles for vibrato and LFO
  kEnableVib  ctrl7 giCtrlChn, giVibOnCC, 0, 1
  kEnableTrem ctrl7 giCtrlChn, giTremOnCC, 0, 1

  ;If vibrato is enabled, send to Cps.
  if kEnableVib = 1 then
    kCps *= kVib+1
  endif

  ;If tremolo is enabled, send to Amp.
  if kEnableTrem = 1 then
    kTrem = 1-(kVib*10) ;produce a value that is worthwhile for tremolo.
  else
    kTrem = 1
  endif

  ;Control detune amount. Detune is distributed both above and below tonal center.
  kDetuneUp1   = (kDetuneCtrl*0.04)+1
  kDetuneDown1 = (kDetuneCtrl*-0.04)+1
  kDetuneUp2   = (kDetuneCtrl*0.025)+1
  kDetuneDown2 = (kDetuneCtrl*-0.025)+1
  kDetuneUp3   = (kDetuneCtrl*0.01)+1
  kDetuneDown3 = (kDetuneCtrl*-0.01)+1

  ;Random number generators for each of the oscillator's phase.
  iRand1 random 0, 1
  iRand2 random 0, 1
  iRand3 random 0, 1
  iRand4 random 0, 1
  iRand5 random 0, 1
  iRand6 random 0, 1

  ;Amplitude control
  iAtk ctrl7 giPadsChn, giAtkCC, 0.001, 2
  iDec ctrl7 giPadsChn, giDecCC, 0.001, 2
  iSus ctrl7 giPadsChn, giSusCC, 0, 1
  iRel ctrl7 giPadsChn, giRelCC, 0.001, 2

  ;ADSR envelope
  aEnv madsr iAtk, iDec, iSus, iRel

  ;Equal distribution of pan.
  iPan1 = 0
  iPan2 = 1
  iPan3 = 0.8
  iPan4 = 0.2
  iPan5 = 0.4
  iPan6 = 0.6

  ;Scale oscillators so that none peak at 0dB.
  iScale = 1/6

  ;Force oscillator to reinitialize when iMode updates.
  kUpdate changed kChangeMode
  if kUpdate = 1 then
    reinit REINIT_OSC
  endif

  REINIT_OSC:

  iMode = i(kChangeMode)

  ;Six oscillators running simultaneously. Creates a large supersaw synth pad.
  aOsc1 vco2 iAmp*kTrem, kCps*kDetuneUp1, iMode, 0, iRand1
  aOsc1 *= iScale
  aOsc1L, aOsc1R pan2 aOsc1, iPan1

  aOsc2 vco2 iAmp*kTrem, kCps*kDetuneDown1, iMode, 0, iRand2
  aOsc2 *= iScale
  aOsc2L, aOsc2R pan2 aOsc2, iPan2

  aOsc3 vco2 iAmp*kTrem, kCps*kDetuneUp2, iMode, 0, iRand3
  aOsc3 *= iScale
  aOsc3L, aOsc3R pan2 aOsc3, iPan3

  aOsc4 vco2 iAmp*kTrem, kCps*kDetuneDown2, iMode, 0, iRand4
  aOsc4 *= iScale
  aOsc4L, aOsc4R pan2 aOsc4, iPan4

  aOsc5 vco2 iAmp*kTrem, kCps*kDetuneUp3, iMode, 0, iRand5
  aOsc5 *= iScale
  aOsc5L, aOsc5R pan2 aOsc5, iPan5

  aOsc6 vco2 iAmp*kTrem, kCps*kDetuneDown3, iMode, 0, iRand6
  aOsc6 *= iScale
  aOsc6L, aOsc6R pan2 aOsc6, iPan6

  ;Sum all the oscillators
  aOscL = aOsc1L+aOsc2L+aOsc3L+aOsc4L+aOsc5L+aOsc6L
  aOscR = aOsc1R+aOsc2R+aOsc3R+aOsc4R+aOsc5R+aOsc6R

  ;Shape amplitude with ADSR envelope.
  aOscL *= aEnv
  aOscR *= aEnv

  ;Filter controls
  iFilterAtk ctrl7 giPadsChn, giLPAtkCC, 0.001, 2
  iFilterDec ctrl7 giPadsChn, giLPDecCC, 0.001, 2
  iFilterAmp ctrl7 giCtrlChn, giLPAmpCC, 1, 100
  kCutCtrl   ctrl7 giCtrlChn, giLPSynthCC, 20, 20000

  ;Filter envelope
  kFilterEnv madsr iFilterAtk, iFilterDec, 0, iRel
  kCutFreq = kCutCtrl*((kFilterEnv*iFilterAmp)+1)

  ;Make sure that the cutoff does NOT exceed 20kHz in order to avoid problems.
  if kCutFreq > 20000 then
    kCutFreq = 20000
  else
    kCutFreq = kCutFreq
  endif

  ;Filter
  aOutL moogladder aOscL, kCutFreq, 0.3
  aOutR moogladder aOscR, kCutFreq, 0.3

  aOutL *= giScale
  aOutR *= giScale

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

instr MultiFX
  /**************************************

  DELOPPGAVE 2 - Multieffekt-modul

  **************************************/

  aLeft  inleta "InLeft"
  aRight inleta "InRight"

  ;MIDI CC controls
  kChoFreq  ctrl7 giKeysChn, giChoFreqCC, 0.5, 10
  kChoDepth ctrl7 giKeysChn, giChoDeptCC, 0.1, 2
  kRevFeed ctrl7 giKeysChn, giRevFdbkCC, 0.1, 0.9
  kRevCut  ctrl7 giKeysChn, giRevCutCC, 20, 20000

  ;Mix controls for each effect.
  kChorVol ctrl7 giCtrlChn, giChoMixCC, 0, 1
  kRevVol  ctrl7 giCtrlChn, giRevMixCC, 0, 1
  kShimVol ctrl7 giCtrlChn, giShimMixCC, 0, 1

  ;Chorus effect using UDO
  aChorusL, aChorusR chorus aLeft, aRight, kChoFreq, kChoDepth
  aChorusL *= kChorVol
  aChorusR *= kChorVol

  ;Reverb
  aReverbL, aReverbR reverbsc, aLeft+aChorusL, aRight+aChorusR, kRevFeed, kRevCut
  aReverbL *= kRevVol
  aReverbR *= kRevVol

  ;Create a "shimmer" effect by doubling the frequency of the reverb signal using FFT analysis
  iFFT = 1024
  fAnalyzeL pvsanal aReverbL, iFFT, iFFT/4, iFFT*2, 0
  fAnalyzeR pvsanal aReverbR, iFFT, iFFT/4, iFFT*2, 0

  fShimmerL pvscale fAnalyzeL, 2
  fShimmerR pvscale fAnalyzeR, 2

  aShimmerL pvsynth fShimmerL
  aShimmerR pvsynth fShimmerR

  ;Slight tremolo on the shimmer effect. Two LFOs modulate each other to create variations.
  iTremAmp = 0.2
  kMod  lfo 0.4, 0.5
  kMod *= 0.5
  aTrem lfo iTremAmp, 10*kMod
  aTrem += 1-iTremAmp

  aShimmerL *= aTrem
  aShimmerR *= aTrem

  aShimmerL *= kShimVol
  aShimmerR *= kShimVol

  ;Sum all the effects.
  aOutL = aChorusL+aReverbL+aShimmerL
  aOutR = aChorusR+aReverbR+aShimmerR

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

/**************************************

Additional instruments used in the
musical piece.

**************************************/

;Sampler with retrigger
instr Sampler
  iNote notnum
  iAmp ampmidi 1

  ;Get tempo from score.
  kBPM miditempo

  ;Decide the size of each sample slice.
  iCutLength = 8 ;Eight note
  kBeat = 60/kBPM
  kLength = kBeat*(4/iCutLength)

  ;This particular slice needs to be longer than an 8th.
  if iNote = 49 then
    kLength *= 2
  else
    kLength = kLength
  endif

  kTrig16 ctrl7 giPadsChn, giTrig16CC, 0, 1
  kTrig24 ctrl7 giPadsChn, giTrig24CC, 0, 1
  kTrig32 ctrl7 giPadsChn, giTrig32CC, 0, 1

  if kTrig16+kTrig24+kTrig32 > 1 then
      ;Retrigger limit at 0.2 seconds. Max 3 instances at a time.
      schedkwhen 1, 0.2, 3, "AmenBreak", 0, kLength, iNote, iAmp, iCutLength
    elseif kTrig16 = 1 then
      ;Retrigger limit at 16th note intervals. Max 1 instance.
      schedkwhen 1, kBeat/4, 1, "AmenBreak", 0, kBeat/4, iNote, iAmp, iCutLength
    elseif kTrig24 = 1 then
      ;Retrigger limit at 16th note tuplet intervals. Max 1 instance.
      schedkwhen 1, kBeat/6, 1, "AmenBreak", 0, kBeat/6, iNote, iAmp, iCutLength
    elseif kTrig32 = 1 then
      ;Retrigger limit at 32nd note intervals. Max 1 instance.
      schedkwhen 1, kBeat/8, 1, "AmenBreak", 0, kBeat/8, iNote, iAmp, iCutLength
    else
      ;Retrigger limit at 0.2 seconds. Max 3 instances at a time.
      schedkwhen 1, 0.2, 3, "AmenBreak", 0, kLength, iNote, iAmp, iCutLength
  endif

endin

;Sampler module for Amen Break
instr AmenBreak
  iNote = p4
  iAmp = p5
  iCutLength = p6
  iLength = ftlen(giAmen)
  aEnv madsr 0.0001, 0.0001, 1, 0.01

  ;How many 4th notes are there in the file/loop?
  iBeats = 16

  ;Get target tempo from score/MIDI.
  kBPM miditempo

  ;Calculates the amount of slices there will be, given the current parameters.
  iCuts = iBeats/(4/iCutLength)

  ;Calculate how long a 4th note is in seconds, then convert that time to samples,
  ;and finally multiply that with the amount of 4th notes there are in the loop.
  kNewLength = ((60/kBPM)*sr)*iBeats

  ;Frequency adjusted to tempo
  kCps = sr/kNewLength

  ;Check MIDI note number and select the correct slice.
  if iNote = 36 then
      iStart = 8/iCuts
    elseif iNote = 37 then
      iStart = 9/iCuts
    elseif iNote = 38 then
      iStart = 10/iCuts
    elseif iNote = 39 then
      iStart = 11/iCuts
    elseif iNote = 40 then
      iStart = 12/iCuts
    elseif iNote = 41 then
      iStart = 13/iCuts
    elseif iNote = 42 then
      iStart = 14/iCuts
    elseif iNote = 43 then
      iStart = 15/iCuts
    elseif iNote = 44 then
      iStart = 20/iCuts
    elseif iNote = 45 then
      iStart = 21/iCuts
    elseif iNote = 46 then
      iStart = 22/iCuts
    elseif iNote = 47 then
      iStart = 23/iCuts
    elseif iNote = 48 then
      iStart = 28/iCuts
    elseif iNote = 49 then
      iStart = 29/iCuts
    elseif iNote = 50 then
      iStart = 31/iCuts
    elseif iNote = 51 then
      iStart = 0
    else goto SKIP_SAMPLE
  endif

  ;Print warning and skip playback, if necessary.
  if iStart >= 1 then
    prints "WARNING: Sample start value %d exceeds or is equal the total amount of cuts, which is %d\n", iCuts*iStart, iCuts
    goto SKIP_SAMPLE
  endif

  ;Iterate through the table at the speed of Cps of the target tempo.
  aPlay phasor kCps, iStart
  aSample table aPlay*iLength, giAmen
  aSample *= iAmp
  aSample *= aEnv

  SKIP_SAMPLE:

  ;Filterkontroll
  kCutoff ctrl7 giPadsChn, giBrkCutCC, 0.001, 1
  kReso   ctrl7 giPadsChn, giBrkResCC, 0, 0.8

  ;Exponential curve for filter cutoff, for more natural scaling.
  kCurved expcurve kCutoff, 8
  kCurved *= 20000

  aFilter moogladder aSample, kCurved, kReso

  aOut = aFilter
  aOut *= giScale

  outleta "OutLeft",  aOut
  outleta "OutRight", aOut
endin

;Simple reverb for the breakbeats.
instr BreakVerb
  aL inleta "InLeft"
  aR inleta "InRight"

  kRevFdbk ctrl7 giPadsChn, giBrkRevFbkCC, 0.1, 0.9
  kRevMix  ctrl7 giPadsChn, giBrkRevMixCC, 0, 0.5

  aRevL, aRevR reverbsc aL, aR, kRevFdbk, 8000

  aRevL *= kRevMix
  aRevR *= kRevMix

  outleta "OutLeft",  aRevL
  outleta "OutRight", aRevR
endin

;Harmonizer for vocals (CODE NOT OPERATING AS INTENDED)
instr Harmonizer
  aIn inleta "Input"

  kCps cpsmidib 2

  ;FFT analysis to repitch
  iFFT = 1024
  fAnalyze pvsanal aIn, iFFT, iFFT/4, iFFT*2, 0

  ;Analyses input pitch and calculates the factor to reach target pitch.
  kPitch, kAmp pitchamdf aIn, 20, 2000
  if kPitch = 0 goto SKIP_HARMONIZER ;avoid divide by zero error.
  kCps /= kPitch ;Get repitching factor.
  ;printk 0.1, kCps

  ;Scale to the new pitch.
  fScale pvscale fAnalyze, kCps

  aOut pvsynth fScale

  SKIP_HARMONIZER:

  aOut *= giScale

  outleta "Output", aOut
endin

;Same as previous detune: this one is being used as the vocoder carrier.
instr Detune2
  iAmp ampmidi 1
  kCps cpsmidib 2

  kGetWave    ctrl7 giCtrlChn, giWaveCC, 0, 1.99
  kDetuneCtrl ctrl7 giKeysChn, giDetCC, 0, 2

  kChangeMode table kGetWave, giWaveform

  kVibAmount  ctrl7 giKeysChn, giVibCC, 0, 0.1
  kVib lfo kVibAmount, 6

  kEnableVib  ctrl7 giCtrlChn, giVibOnCC, 0, 1
  kEnableTrem ctrl7 giCtrlChn, giTremOnCC, 0, 1

  if kEnableVib = 1 then
    kCps *= kVib+1
  endif

  if kEnableTrem = 1 then
    kTrem = 1-(kVib*10)
  else
    kTrem = 1
  endif

  kDetuneUp1   = (kDetuneCtrl*0.04)+1
  kDetuneDown1 = (kDetuneCtrl*-0.04)+1
  kDetuneUp2   = (kDetuneCtrl*0.025)+1
  kDetuneDown2 = (kDetuneCtrl*-0.025)+1
  kDetuneUp3   = (kDetuneCtrl*0.01)+1
  kDetuneDown3 = (kDetuneCtrl*-0.01)+1

  iRand1 random 0, 1
  iRand2 random 0, 1
  iRand3 random 0, 1
  iRand4 random 0, 1
  iRand5 random 0, 1
  iRand6 random 0, 1

  iAtk ctrl7 giPadsChn, giAtkCC, 0.001, 2
  iDec ctrl7 giPadsChn, giDecCC, 0.001, 2
  iSus ctrl7 giPadsChn, giSusCC, 0, 1
  iRel ctrl7 giPadsChn, giRelCC, 0.001, 2
  
  aEnv madsr iAtk, iDec, iSus, iRel

  iPan1 = 0
  iPan2 = 1
  iPan3 = 0.8
  iPan4 = 0.2
  iPan5 = 0.4
  iPan6 = 0.6

  iScale = 1/6

  kUpdate changed kChangeMode
  if kUpdate = 1 then
    reinit REINIT_OSC
  endif

  REINIT_OSC:

  iMode = i(kChangeMode)

  aOsc1 vco2 iAmp*kTrem, kCps*kDetuneUp1, iMode, 0, iRand1
  aOsc1 *= iScale
  aOsc1L, aOsc1R pan2 aOsc1, iPan1

  aOsc2 vco2 iAmp*kTrem, kCps*kDetuneDown1, iMode, 0, iRand2
  aOsc2 *= iScale
  aOsc2L, aOsc2R pan2 aOsc2, iPan2

  aOsc3 vco2 iAmp*kTrem, kCps*kDetuneUp2, iMode, 0, iRand3
  aOsc3 *= iScale
  aOsc3L, aOsc3R pan2 aOsc3, iPan3

  aOsc4 vco2 iAmp*kTrem, kCps*kDetuneDown2, iMode, 0, iRand4
  aOsc4 *= iScale
  aOsc4L, aOsc4R pan2 aOsc4, iPan4

  aOsc5 vco2 iAmp*kTrem, kCps*kDetuneUp3, iMode, 0, iRand5
  aOsc5 *= iScale
  aOsc5L, aOsc5R pan2 aOsc5, iPan5

  aOsc6 vco2 iAmp*kTrem, kCps*kDetuneDown3, iMode, 0, iRand6
  aOsc6 *= iScale
  aOsc6L, aOsc6R pan2 aOsc6, iPan6

  aOscL = aOsc1L+aOsc2L+aOsc3L+aOsc4L+aOsc5L+aOsc6L
  aOscR = aOsc1R+aOsc2R+aOsc3R+aOsc4R+aOsc5R+aOsc6R

  aOscL *= aEnv
  aOscR *= aEnv

  iFilterAtk ctrl7 giPadsChn, giLPAtkCC, 0.001, 2
  iFilterDec ctrl7 giPadsChn, giLPDecCC, 0.001, 2
  iFilterAmp ctrl7 giCtrlChn, giLPAmpCC, 1, 100
  kCutCtrl   ctrl7 giCtrlChn, giLPSynthCC, 20, 20000

  kFilterEnv madsr iFilterAtk, iFilterDec, 0, iRel
  kCutFreq = kCutCtrl*((kFilterEnv*iFilterAmp)+1)

  if kCutFreq > 20000 then
    kCutFreq = 20000
  else
    kCutFreq = kCutFreq
  endif

  aOutL moogladder aOscL, kCutFreq, 0.3
  aOutR moogladder aOscR, kCutFreq, 0.3

  aOutL *= giScale
  aOutR *= giScale

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

;Channel vocoder with stereo output
instr Vocoder
  aMod  inleta "Modulator"
  aCarL inleta "CarrierLeft"
  aCarR inleta "CarrierRight"

  ;Analyze all input signals
  iFFT = 256

  ;Use stereo vocoder UDO.
  aOutL, aOutR vocoders aMod, aCarL, aCarR, iFFT

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

;MIDI triggered freeze effect.
instr Freeze
  aL inleta "InLeft"
  aR inleta "InRight"

  ;Use MIDI CC button to activate freeze.
  kEnable ctrl7 giPadsChn, giFreezeCC, 0, 1

  iFFT = 1024
  fAnalyzeL pvsanal aL, iFFT, iFFT/4, iFFT*2, 0
  fAnalyzeR pvsanal aR, iFFT, iFFT/4, iFFT*2, 0

  ;Freeze amplitude and pitch
  fFreezeL pvsfreeze fAnalyzeL, kEnable, kEnable
  fFreezeR pvsfreeze fAnalyzeR, kEnable, kEnable

  aResynthL pvsynth fFreezeL
  aResynthR pvsynth fFreezeR

  ;Filter control
  kCutoff ctrl7 giPadsChn, giLPFreezeCC, 0.001, 1

  ;Exponential curve for filter cutoff
  kCurved expcurve kCutoff, 8
  kCurved *= 20000

  aOutL moogladder aResynthL, kCurved, 0.1
  aOutR moogladder aResynthR, kCurved, 0.1

  ;If freeze is not enabled, just output the clean signal.
  if kEnable = 0 then
    aOutL = aL
    aOutR = aR
  endif

  outleta "OutLeft",  aOutL
  outleta "OutRight", aOutR
endin

;MIDI Arpeggiator
instr Arpeggio
  kRate ctrl7 giKeysChn, giArpRateCC, 1, 20
  kNote, kTrigger midiarp kRate, 3 ;Random order on arpeggiated notes.

  kCps = cpsmidinn(kNote)

  ;i-event has same duration as the arp rate.
  kDur = 1/kRate

  ;Trigger arpeggio synth.
  if kTrigger = 1 then
    event "i", "ArpSynth", 0, kDur, kCps
  endif

  SKIP:
endin

;Arpeggio synth with glide between each note
instr ArpSynth

  iInCps cpsmidi
  iAmp ampmidi 1

  ;Avoid glide from 0 Hz on the first note that's played
  if gkOldCps = 0 then
    gkOldCps = iInCps
    reinit GLIDE
  endif

  GLIDE:
  ;Draw a line from previous pitch to the new pitch.
  kCps linseg i(gkOldCps), 0.01, iInCps

  iPhase1 random 0, 1
  iPhase2 random 0, 1
  iPhase3 random 0, 1

  aEnv madsr 0.001, 0.2, 0, 0.01
  aOsc1 oscil iAmp/3, kCps, giHammond, iPhase1
  aOsc2 oscil iAmp/3, kCps, giHammond, iPhase2
  aOsc3 oscil iAmp/3, kCps, giHammond, iPhase3
  aOsc1 *= aEnv
  aOsc2 *= aEnv
  aOsc3 *= aEnv

  aOsc = aOsc1+aOsc2+aOsc3

  kCutoff ctrl7 giKeysChn, giLPArpCC, 0, 1
  kCurved expcurve kCutoff, 8
  kCurved *= 20000

  aOut moogladder aOsc, kCurved, 0.4
  aOut *= giScale

  ;Store current pitch as previous pitch
  gkOldCps = kCps

  outleta "Output",  aOut
endin

instr ArpReverb
  aL inleta "InLeft"
  aR inleta "InRight"

  aRevL, aRevR reverbsc aL, aR, 0.8, 8000

  aRevL *= 0.1
  aRevR *= 0.1

  outleta "OutLeft",  aRevL
  outleta "OutRight", aRevR
endin

;Simple line/mic input
instr Microphone
  aIn inch 1
  outleta "Output", aIn
endin

;Custom tempo clock, so that instruments can get BPM fra Csound score. (Useful if you need to test from score.)
instr BPM
  iBPM = p4
  tempo p4, 60 ;Set tempo using p-field.

  ;Print the new tempo to console.
  prints "Current BPM: %d\n", iBPM
endin

;Metronome sound that does not reach the master channel.
instr Metronome
  iCps cpsmidi
  aEnv madsr 0.001, 0.1, 0, 0.001
  aOut oscil 1, iCps
  aOut *= aEnv
  aOut *= 0.2
  ;outs aOut, aOut
endin

;Master output
instr Master
  aLeft  inleta "InLeft"
  aRight inleta "InRight"

  ;Send audio to output
  outs aLeft, aRight

  ;Write audio to disk.
  fout "render.wav", 14, aLeft, aRight
endin

</CsInstruments>

<CsScore>
;i"BPM" 0 60 60
</CsScore>

</CsoundSynthesizer>
