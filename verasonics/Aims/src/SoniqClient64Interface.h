// This file was generated by
// GenerateSoniqClientInterface.exe, from
// SoniqClient.dpr, Delphi source for
// SoniqClient.dll version 5.3.7.1
// 2019-03-01 12:29:33

long ErrorInt();
double ErrorDbl();
int Connected();
void GetSoniqClientVersion(char* value);
int OpenSoniqConnection(char* AHost);
int SoniqRunning();
int CloseSoniqConnection();
void GetSoniqEXEPath(char* value);
void SetPositionerLowLimit(long int axis,double value);
double GetPositionerLowLimit(long int axis);
void SetPositionerHighLimit(long int axis,double value);
double GetPositionerHighLimit(long int axis);
long GetPositionerStepsPerSecond(long int axis);
void SetPositionerStepsPerSecond(long int axis,long int value);
void PositionerMoveRel(long int axis,double value);
void PositionerMoveAbs(long int axis,double value);
void SetPosition(long int axis,double value);
double GetPosition(long int axis);
void FindLimitSwitch(long int axis,int value);
int GetLimitSwitchState(long int axis,int value);
void GetPositionerModel(char* value);
void GetPositionerSerial(char* value);
void GetPositionerFirmwareVersion(char* value);
int GetPositionerTranslation(long int axis);
void SetPositionerTranslation(long int axis,int value);
void GetPositionerAxisName(long int axis,char* value);
void GetPositionerUnits(long int axis,char* value);
double GetPositionerScaleFactor(long int axis);
long GetPositionerAxisCount();
int GetPositionerReversed(long int axis);
void SetPositionerReversed(long int axis,int value);
int GetAngPosInstalled();
int GetUseMachineCoordinates();
void SetUseMachineCoordinates(int value);
long ShowScopeDialog();
void ShowScopeWaveformWindow(int value);
void SetScopeSensitivity(long int ch,double value);
double GetScopeSensitivity(long int ch);
void SetScopeOffset(long int ch,double value);
double GetScopeOffset(long int ch);
void SetScopeCoupling(long int ch,char* value);
void GetScopeCoupling(long int ch,char* value);
void SetScopeProbe(long int ch,double value);
double GetScopeProbe(long int ch);
void SetScopeBWLimited(long int ch,int value);
int GetScopeBWLimited(long int ch);
void SetScopeInverted(long int ch,int value);
int GetScopeInverted(long int ch);
void SetScopeTimebase(double value);
double GetScopeTimebase();
double GetScopeMinVPerDiv(long int ch);
double GetScopeMaxVPerDiv(long int ch);
double GetScopeMinSecPerDiv();
double GetScopeMaxSecPerDiv();
void SetScopeDelay(double value);
double GetScopeDelay();
void SetScopePoints(long int value);
long GetScopePoints();
long GetScopeMaxPoints();
long GetScopeMaxAvailablePoints();
void SetScopeWFSource(long int value);
long GetScopeWFSource();
void SetScopeWFAverage(int value);
void SetScopeWFAveraging(long int value);
int GetScopeWFAverage();
long GetScopeWFAveraging();
void SetScopeWFRemoteAveraging(int value);
int GetScopeWFRemoteAveraging();
void SetScopeUseCorrelation(int value);
int GetScopeUseCorrelation();
void SetScopeRealTime(int value);
int GetScopeRealTime();
void GetScopeModel(char* value);
void GetScopeSerial(char* value);
void GetScopeFirmwareVersion(char* value);
void ScopeWrite(char* value);
void ScopeRead(char* value);
void SetScopeTriggerSource(char* value);
void GetScopeTriggerSource(char* value);
void SetScopeTriggerMode(char* value);
void GetScopeTriggerMode(char* value);
void SetScopeTriggerCoupling(char* value);
void GetScopeTriggerCoupling(char* value);
void SetScopeTriggerSlope(int value);
int GetScopeTriggerSlope();
void SetScopeTriggerLevel(double value);
double GetScopeTriggerLevel();
long GetScopeChannelCount();
long ShowFunctionGeneratorDialog();
void SetFunctionGeneratorFrequency(double value);
double GetFunctionGeneratorFrequency();
void SetFunctionGeneratorVoltsPeakToPeak(double value);
double GetFunctionGeneratorVoltsPeakToPeak();
void SetFunctionGeneratorOffset(double value);
double GetFunctionGeneratorOffset();
void SetFunctionGeneratorFunction(char* value);
void GetFunctionGeneratorFunction(char* value);
void SetFunctionGeneratorMode(char* value);
void GetFunctionGeneratorMode(char* value);
void SetFunctionGeneratorBurstCount(long int value);
long GetFunctionGeneratorBurstCount();
void SetFunctionGeneratorPRF(double value);
double GetFunctionGeneratorPRF();
void SetFunctionGeneratorEnabled(int value);
int GetFunctionGeneratorEnabled();
void GetFunctionGeneratorModel(char* value);
void GetFunctionGeneratorSerial(char* value);
void GetFunctionGeneratorFirmwareVersion(char* value);
void FunctionGeneratorWrite(char* value);
void FunctionGeneratorRead(char* value);
long ShowWaterConditionerDialog();
void SetWaterConditionerMode(long int value);
long GetWaterConditionerMode();
void SetWaterConditionerSetPoint(double value);
double GetWaterConditionerSetPoint();
int GetWaterConditionerOK();
long GetWaterConditionerState();
long GetWaterConditionerError();
double GetWaterConditionerTemperature();
double GetWaterConditionerFlow();
double GetWaterConditionerFirmwareVersion();
long ShowMeasSetupDialog();
void SetXdcrModel(char* value);
void GetXdcrModel(char* value);
void SetXdcrSerial(char* value);
void GetXdcrSerial(char* value);
void SetSystemModel(char* value);
void GetSystemModel(char* value);
void SetSystemSerial(char* value);
void GetSystemSerial(char* value);
void SetSystemSoftwareRev(char* value);
void GetSystemSoftwareRev(char* value);
void SetXdcrMode(char* value);
void GetXdcrMode(char* value);
void SetXdcrFreqMHz(double value);
double GetXdcrFreqMHz();
void SetXdcrPRFHz(double value);
double GetXdcrPRFHz();
void SetXdcrPowermW(double value);
double GetXdcrPowermW();
void SetXdcrBoundedPowermW(double value);
double GetXdcrBoundedPowermW();
void SetXdcrBoundedSqrPowermW(double value);
double GetXdcrBoundedSqrPowermW();
void SetXdcrScanned(int value);
int GetXdcrScanned();
void SetXdcrXDim(double value);
double GetXdcrXDim();
void SetXdcrYDim(double value);
double GetXdcrYDim();
void SetXdcrDiameter(double value);
double GetXdcrDiameter();
void SetXdcrCircular(int value);
int GetXdcrCircular();
double GetXdcrApertureArea();
void SetXdcrApertureXWidth(double value);
double GetXdcrApertureXWidth();
void SetXdcrFLX(double value);
double GetXdcrFLX();
void SetXdcrFLY(double value);
double GetXdcrFLY();
void SetXdcrCurvedArray(int value);
int GetXdcrCurvedArray();
void SetXdcrSectorScanner(int value);
int GetXdcrSectorScanner();
void SetXdcrRadius(double value);
double GetXdcrRadius();
void SetXdcrLineSpacing(double value);
double GetXdcrLineSpacing();
void SetXdcrLineIncrementalAngle(double value);
double GetXdcrLineIncrementalAngle();
void SetXdcrLineCount(long int value);
long GetXdcrLineCount();
void SetXdcrFrameRate(double value);
double GetXdcrFrameRate();
double GetXdcrZbpcm();
void SetXdcrCranialUse(int value);
int GetXdcrCranialUse();
void SetXdcrControl(long int index,char* value);
void GetXdcrControl(long int index,char* value);
void HydrophoneClearSens();
void GetHydrophoneFileName(char* value);
void HydrophoneReadXLS(char* value);
void SetHydrophoneModel(char* value);
void GetHydrophoneModel(char* value);
void SetHydrophoneSerial(char* value);
void GetHydrophoneSerial(char* value);
void SetPreampModel(char* value);
void GetPreampModel(char* value);
void SetPreampSerial(char* value);
void GetPreampSerial(char* value);
void SetHydrophoneVperMPa(double value);
double GetHydrophoneVperMPa();
void SetHydrophoneInverted(int value);
int GetHydrophoneInverted();
void SetUser(char* value);
void GetUser(char* value);
void ClearComments();
void AddComment(char* value);
void UserEditComments();
double GetDeratingFactor();
long ShowTankSetupDialog();
void SetTemperature(double value);
double GetTemperature();
void SetVelocity(double value);
double GetVelocity();
void SetRoundTrip(int value);
int GetRoundTrip();
void SetOrientationZAxis(long int value);
long GetOrientationZAxis();
void SetOrientationXAxis(long int value);
long GetOrientationXAxis();
void SetOrientationYAxis(long int value);
long GetOrientationYAxis();
void SetOrientationAzAxis(long int value);
long GetOrientationAzAxis();
void SetOrientationElevAxis(long int value);
long GetOrientationElevAxis();
void SetDistanceTrackingEnabled(int value);
int GetDistanceTrackingEnabled();
void SetUseDiagonal(int value);
int GetUseDiagonal();
void SetDistanceTrackingOffset(double value);
double GetDistanceTrackingOffset();
double GetDistanceTrackingDelay();
void ApplyDistanceTracking();
void SetXAngle(double value);
double GetXAngle();
void SetYAngle(double value);
double GetYAngle();
void SetZAngle(double value);
double GetZAngle();
void GetDataType(char* value);
int GetDataValid();
void DigitizeWaveform();
void GetWaveformData(double *data,long int count);
void GetPIIData(double *data,long int count);
void GetWaveformSpectrumData(double *data,long int count);
void SetWaveformTitle(char* value);
long GetWaveformPoints();
long GetWaveformSpectrumPoints();
double GetWaveformSpectrumXMax();
double GetWaveformDataPoint(long int index);
void SetWaveformAutoscale(int value);
int GetWaveformAutoscale();
void ClearWaveform();
void SetWaveformView(char* value);
void GetWaveformView(char* value);
void ClearWaveformParameters();
void AddWaveformParameter(char* value);
void GetWaveformParameter(long int index,char* value);
double GetWaveformParameterValue(long int index);
double WaveformCalculate(char* param);
void CopyWaveformFcToSetupData();
long Show1DScanDialog();
long Start1DScan();
void Get1DScanData(double *data,long int count);
double Get1DScanDataPoint(long int index);
double Get1DScanPosition(long int index);
void Set1DScanAutoScale(int value);
int Get1DScanAutoScale();
void Clear1DScan();
void Set1DScanAxis(long int value);
long Get1DScanAxis();
void Set1DScanPoints(long int value);
long Get1DScanPoints();
void Set1DScanStart(double value);
double Get1DScanStart();
void Set1DScanEnd(double value);
double Get1DScanEnd();
void Set1DScanPause(long int value);
long Get1DScanPause();
void Set1DScanAfterScan(char* value);
void Get1DScanAfterScan(char* value);
void Clear1DScanParameters();
void Add1DScanParameter(char* value);
void Get1DScanParameter(long int index,char* value);
void Set1DScanSelected(long int value);
long Get1DScanSelected();
void Set1DScanView(char* value);
void Get1DScanView(char* value);
void MoveTo1DScanPeak();
void MoveTo1DScanDeratedPeak();
void MoveTo1DScanLAM();
double Get1DScanPeak();
double Get1DScanDeratedPeak();
double Get1DScanLAM();
double Get1DScanPeakLocation();
double Get1DScanInterpolatedPeakLocation();
long Get1DScanPeakIndex();
long Get1DScanDeratedPeakIndex();
long Get1DScanLAMIndex();
double Get1DScanDeratedPeakLocation();
double Get1DScanLAMLocation();
double Get1DScanWidth(double db_level);
int Get1DScanRecordWaveforms();
void Set1DScanRecordWaveforms(int value);
void Set1DScanRealTimePlotting(int value);
int Get1DScanRealTimePlotting();
double Get1DScanElapsedTime();
double Get1DScanTimePerPoint();
long ShowZScanDialog();
long StartZScan();
void GetZScanData(double *data,long int count);
double GetZScanDataPoint(long int index);
double GetZScanPosition(long int index);
void SetZScanAutoScale(int value);
int GetZScanAutoScale();
void SetZScanCalcPer62359Ed2(int value);
int GetZScanCalcPer62359Ed2();
void ClearZScan();
void SetZScanPoints(long int value);
long GetZScanPoints();
void SetZScanStart(double value);
double GetZScanStart();
void SetZScanEnd(double value);
double GetZScanEnd();
void SetZScanPause(long int value);
long GetZScanPause();
void SetZScanAfterScan(char* value);
void GetZScanAfterScan(char* value);
void SetZScanSelected(long int value);
long GetZScanSelected();
void GetZScanParameter(long int index,char* value);
void SetZScanView(char* value);
void GetZScanView(char* value);
void MoveToZScanPeak();
void MoveToZScanDeratedPeak();
void MoveToZScanLAM();
double GetZScanPeak();
double GetZScanDeratedPeak();
double GetZScanLAM();
double GetZScanPeakLocation();
double GetZScanDeratedPeakLocation();
double GetZScanLAMLocation();
double GetZScanWidth(double db_level);
double GetZScanCalcResult(long int index);
void GetZScanCalcLabel(long int index,char* value);
void GetZScanCalcUnits(long int index,char* value);
void SetZScanRealTimePlotting(int value);
int GetZScanRealTimePlotting();
long Show2DScanDialog();
long Start2DScan();
void Get2DScanData(double *data,long int count);
double Get2DScanDataPoint(long int index1,long int index2);
double Get2dScanFirstPosition(long int index);
double Get2dScanSecondPosition(long int index);
void Set2DScanAutoScale(int value);
int Get2DScanAutoScale();
void Clear2DScan();
void Set2DScanFirstAxis(long int value);
long Get2DScanFirstAxis();
void Set2DScanSecondAxis(long int value);
long Get2DScanSecondAxis();
void Set2DScanFirstPoints(long int value);
long Get2DScanFirstPoints();
void Set2DScanSecondPoints(long int value);
long Get2DScanSecondPoints();
void Set2DScanFirstStart(double value);
double Get2DScanFirstStart();
void Set2DScanSecondStart(double value);
double Get2DScanSecondStart();
void Set2DScanFirstEnd(double value);
double Get2DScanFirstEnd();
void Set2DScanSecondEnd(double value);
double Get2DScanSecondEnd();
void Set2DScanPause(long int value);
long Get2DScanPause();
void Set2DScanElliptical(int value);
int Get2DScanElliptical();
void Set2DScanAfterScan(char* value);
void Get2DScanAfterScan(char* value);
void Clear2DScanParameters();
void Add2DScanParameter(char* value);
void Get2DScanParameter(long int index,char* value);
void Set2DScanSelected(long int value);
long Get2DScanSelected();
void Set2DScanColorScheme(char* value);
void Get2DScanColorScheme(char* value);
void Set2DScanAltitude(long int value);
long Get2DScanAltitude();
void Set2DScanAzimuth(long int value);
long Get2DScanAzimuth();
void Set2DScanKeepAspectRatio(int value);
int Get2DScanKeepAspectRatio();
void Set2DScanViewPerspective(int value);
int Get2DScanViewPerspective();
void Set2DScanView(char* value);
void Get2DScanView(char* value);
void Set2DScanViewWater(int value);
void Set2DScanViewDerated(int value);
int Get2DScanViewDerated();
int Get2DScanViewWater();
void MoveTo2DScanPeak();
void MoveTo2DScanDeratedPeak();
void MoveTo2DScanLAM();
double Get2DScanPeak();
double Get2DScanDeratedPeak();
double Get2DScanLAM();
double Get2DScanFirstPeakLocation();
double Get2DScanFirstDeratedPeakLocation();
double Get2DScanFirstLAMLocation();
double Get2DScanSecondPeakLocation();
double Get2DScanSecondDeratedPeakLocation();
double Get2DScanSecondLAMLocation();
double Get2DScanPower(double db_limit);
double Get2DScanFirstWidth(double db_limit);
double Get2DScanSecondWidth(double db_limit);
double Get2DScanArea(double db_limit);
double Get2DScanIntegrationLimit();
void Set2DScanIntegrationLimit(double value);
void Copy2DScanPowerToSetupData();
int Get2DScanRecordWaveforms();
void Set2DScanRecordWaveforms(int value);
void Set2DScanRealTimePlotting(int value);
int Get2DScanRealTimePlotting();
long ShowXYScanDialog();
long StartXYScan();
void GetXYScanData(double *data,long int count);
double GetXYScanDataPoint(long int x,long int y);
double GetXYScanXPosition(long int x);
double GetXYScanYPosition(long int y);
void SetXYScanAutoScale(int value);
int GetXYScanAutoScale();
void ClearXYScan();
void SetXYScanXPoints(long int value);
long GetXYScanXPoints();
void SetXYScanYPoints(long int value);
long GetXYScanYPoints();
void SetXYScanXStart(double value);
double GetXYScanXStart();
void SetXYScanYStart(double value);
double GetXYScanYStart();
void SetXYScanXEnd(double value);
double GetXYScanXEnd();
void SetXYScanYEnd(double value);
double GetXYScanYEnd();
void SetXYScanPause(long int value);
long GetXYScanPause();
void SetXYScanElliptical(int value);
int GetXYScanElliptical();
void SetXYScanAfterScan(char* value);
void GetXYScanAfterScan(char* value);
void SetXYScanColorScheme(char* value);
void GetXYScanColorScheme(char* value);
void SetXYScanAltitude(long int value);
long GetXYScanAltitude();
void SetXYScanAzimuth(long int value);
long GetXYScanAzimuth();
void SetXYScanKeepAspectRatio(int value);
int GetXYScanKeepAspectRatio();
void SetXYScanViewPerspective(int value);
int GetXYScanViewPerspective();
void SetXYScanView(char* value);
void GetXYScanView(char* value);
void MoveToXYScanPeak();
double GetXYScanPeak();
double GetXYScanXPeakLocation();
double GetXYScanYPeakLocation();
double GetXYScanPower(double db_limit);
double GetXYScanXWidth(double db_limit);
double GetXYScanYWidth(double db_limit);
double GetXYScanArea(double db_limit);
double GetXYScanIntegrationLimit();
void SetXYScanIntegrationLimit(double value);
void CopyXYScanPowerToSetupData();
void SetXYScanRealTimePlotting(int value);
int GetXYScanRealTimePlotting();
long ShowZXScanDialog();
long StartZXScan();
void GetZXScanData(double *data,long int count);
double GetZXScanDataPoint(long int z,long int x);
double GetZXScanXPosition(long int z);
double GetZXScanZPosition(long int x);
void SetZXScanAutoScale(int value);
int GetZXScanAutoScale();
void ClearZXScan();
void SetZXScanZPoints(long int value);
long GetZXScanZPoints();
void SetZXScanXPoints(long int value);
long GetZXScanXPoints();
void SetZXScanZStart(double value);
double GetZXScanZStart();
void SetZXScanXStart(double value);
double GetZXScanXStart();
void SetZXScanZEnd(double value);
double GetZXScanZEnd();
void SetZXScanXEnd(double value);
double GetZXScanXEnd();
void SetZXScanPause(long int value);
long GetZXScanPause();
void SetZXScanAfterScan(char* value);
void GetZXScanAfterScan(char* value);
void SetZXScanSelected(long int value);
long GetZXScanSelected();
void SetZXScanColorScheme(char* value);
void GetZXScanColorScheme(char* value);
void SetZXScanAltitude(long int value);
long GetZXScanAltitude();
void SetZXScanAzimuth(long int value);
long GetZXScanAzimuth();
void SetZXScanKeepAspectRatio(int value);
int GetZXScanKeepAspectRatio();
void SetZXScanViewPerspective(int value);
int GetZXScanViewPerspective();
void SetZXScanView(char* value);
void GetZXScanView(char* value);
void SetZXScanViewWater(int value);
void SetZXScanViewDerated(int value);
int GetZXScanViewDerated();
int GetZXScanViewWater();
void MoveToZXScanPeak();
void MoveToZXScanDeratedPeak();
void MoveToZXScanLAM();
double GetZXScanPeak();
double GetZXScanDeratedPeak();
double GetZXScanLAM();
double GetZXScanZPeakLocation();
double GetZXScanZDeratedPeakLocation();
double GetZXScanZLAMLocation();
double GetZXScanXPeakLocation();
double GetZXScanXDeratedPeakLocation();
double GetZXScanXLAMLocation();
double GetZXScanZWidth(double db_limit);
double GetZXScanXWidth(double db_limit);
double GetZXScanIspta3();
void SetZXScanRealTimePlotting(int value);
int GetZXScanRealTimePlotting();
long Show3DScanDialog();
long Start3DScan();
void Get3DScanData(double *data,long int count);
void Set3DScanAutoScale(int value);
int Get3DScanAutoScale();
void Clear3DScan();
void Set3DScanXPoints(long int value);
long Get3DScanXPoints();
void Set3DScanYPoints(long int value);
long Get3DScanYPoints();
void Set3DScanZPoints(long int value);
long Get3DScanZPoints();
void Set3DScanXStart(double value);
double Get3DScanXStart();
void Set3DScanYStart(double value);
double Get3DScanYStart();
void Set3DScanZStart(double value);
double Get3DScanZStart();
void Set3DScanXEnd(double value);
double Get3DScanXEnd();
void Set3DScanYEnd(double value);
double Get3DScanYEnd();
void Set3DScanZEnd(double value);
double Get3DScanZEnd();
void Set3DScanZIndex(long int value);
long Get3DScanZIndex();
void Set3DScanPause(long int value);
long Get3DScanPause();
void Set3DScanElliptical(int value);
int Get3DScanElliptical();
void Clear3DScanParameters();
void Add3DScanParameter(char* value);
void Get3DScanParameter(long int index,char* value);
void Set3DScanSelected(long int value);
long Get3DScanSelected();
void Set3DScanRealTimePlotting(int value);
int Get3DScanRealTimePlotting();
long ShowFreqScanDialog();
void SetFreqScanAutoScale(int value);
int GetFreqScanAutoScale();
void SetFreqScanStart(double value);
double GetFreqScanStart();
void SetFreqScanEnd(double value);
double GetFreqScanEnd();
void SetFreqScanPoints(long int value);
long GetFreqScanPoints();
void SetFreqScanXLog(int value);
int GetFreqScanXLog();
void SetFreqScanTrackFrequency(int value);
int GetFreqScanTrackFrequency();
void SetFreqScanDesiredCycles(long int value);
long GetFreqScanDesiredCycles();
void SetFreqScanPause(long int value);
long GetFreqScanPause();
void ClearFreqScanParameters();
void AddFreqScanParameter(char* value);
void GetFreqScanParameter(long int index,char* value);
long FreqScanStartRef();
long FreqScanStartMeas();
void GetFreqScanData(long int which_data,double *data,long int count);
double GetFreqScanDataPoint(long int which_data,long int index);
double GetFreqScanFrequency(long int index);
void SetFreqScanSelected(long int value);
long GetFreqScanSelected();
void SetFreqScanView(char* value);
void GetFreqScanView(char* value);
void SetFreqScanRealTimePlotting(int value);
int GetFreqScanRealTimePlotting();
long ShowFindPulseDialog();
void FindPulseAutoMinMax();
void SetFindPulseMinDelay(double value);
double GetFindPulseMinDelay();
void SetFindPulseMaxDelay(double value);
double GetFindPulseMaxDelay();
long FindPulse();
void AutoScale();
long ShowSearchDialog();
void SetSearchAxis(long int value);
long GetSearchAxis();
void SetSearchStartPos(double value);
double GetSearchStartPos();
void SetSearchEndPos(double value);
double GetSearchEndPos();
void SetSearchPoints(long int value);
long GetSearchPoints();
void SetSearchdBLevel(double value);
double GetSearchdBLevel();
void SetSearchSetToZero(int value);
int GetSearchSetToZero();
void SetSearchAlignToPeak(int value);
int GetSearchAlignToPeak();
double GetSearchPeakLocation();
double GetSearchCenter();
int GetSearchValid();
long StartSearch();
long ShowSearchPlaneDialog();
void SetSearchPlaneXPoints(long int value);
long GetSearchPlaneXPoints();
void SetSearchPlaneXWidth(double value);
double GetSearchPlaneXWidth();
void SetSearchPlaneYPoints(long int value);
long GetSearchPlaneYPoints();
void SetSearchPlaneYWidth(double value);
double GetSearchPlaneYWidth();
void SetSearchPlanedBLevel(double value);
double GetSearchPlanedBLevel();
void SetSearchPlaneSetToZero(int value);
int GetSearchPlaneSetToZero();
void SetSearchPlaneAlignToPeak(int value);
int GetSearchPlaneAlignToPeak();
int GetSearchPlaneValid();
double GetSearchPlaneXPeakLocation();
double GetSearchPlaneXCenter();
double GetSearchPlaneYPeakLocation();
double GetSearchPlaneYCenter();
long StartSearchPlane();
long ShowBeamAlignmentDialog();
void SetBeamAlignmentZ1(double value);
double GetBeamAlignmentZ1();
void SetBeamAlignmentXRange1(double value);
double GetBeamAlignmentXRange1();
void SetBeamAlignmentYRange1(double value);
double GetBeamAlignmentYRange1();
void SetBeamAlignmentXPoints1(long int value);
long GetBeamAlignmentXPoints1();
void SetBeamAlignmentYPoints1(long int value);
long GetBeamAlignmentYPoints1();
void SetBeamAlignmentZ2(double value);
double GetBeamAlignmentZ2();
void SetBeamAlignmentXRange2(double value);
double GetBeamAlignmentXRange2();
void SetBeamAlignmentYRange2(double value);
double GetBeamAlignmentYRange2();
void SetBeamAlignmentXPoints2(long int value);
long GetBeamAlignmentXPoints2();
void SetBeamAlignmentYPoints2(long int value);
long GetBeamAlignmentYPoints2();
void SetBeamAlignmentXLimit(double value);
double GetBeamAlignmentXLimit();
void SetBeamAlignmentYLimit(double value);
double GetBeamAlignmentYLimit();
void SetBeamAlignmentMaxTries(long int value);
long GetBeamAlignmentMaxTries();
void SetBeamAlignmentNZPositions(long int value);
long GetBeamAlignmentNZPositions();
void SetBeamAlignmentAlignToPeak(int value);
int GetBeamAlignmentAlignToPeak();
long StartBeamAlignment();
void ChangeDir(char* value);
void Dir(char* value);
void MakeDir(char* value);
void MakeNewDir();
long Save();
long SaveAutoName();
long SaveFileAs(char* value);
void GetFileName(char* value);
void GetShortFileName(char* value);
long Read(char* value);
long ReadData(char* value);
void CloseFile();
void StartPrintJob();
void FinishPrintJob();
void PrintXdcr();
void PrintHydrophone();
void PrintMedium();
void PrintOrientation();
void PrintDistanceTracking();
void PrintComments();
void PrintPosition();
void PrintScope();
void PrintWaveformPlot();
void PrintWaveformPII();
void PrintWaveformSpectrum();
void PrintWaveformFrequency();
void PrintWaveformVoltages();
void PrintWaveformIntensity();
void PrintWaveformParameters();
void Print1DScanPlot();
void Print1DScanWidth();
void Print2DScanColor();
void Print2DScanContour();
void Print2DScanWireFrame();
void Print2DScanSlice();
void Print2DScanTransducerPower();
void Print2DScanWidth();
void PrintFreqScanRef();
void PrintFreqScanMeas();
void PrintFreqScanGain();
void Pause(long int value);
void MessageBox(char* value,long int flags);
void Copy();
void SetSoniqWindowLeft(long int value);
void SetSoniqWindowTop(long int value);
void SetSoniqWindowWidth(long int value);
void SetSoniqWindowHeight(long int value);
void SetSoniqWindowClientWidth(long int value);
void SetSoniqWindowClientHeight(long int value);
long GetSoniqWindowLeft();
long GetSoniqWindowTop();
long GetSoniqWindowWidth();
long GetSoniqWindowHeight();
long GetSoniqWindowClientWidth();
long GetSoniqWindowClientHeight();
void BringToFront();
void SendToBack();
void GetSoniqVersion(char* value);
void GetSoniqSerialNumber(char* value);
void OutputToXLS();
long CreateOutputTable(char* ModeName,char* Mode1,char* Mode2,char* Mode3,char* OutputFile1,char* OutputFile2,char* FileFmt,int Ed2);
void SetScopeConfig(char* ScopeType,char* ScopeAddr);
void GetScopeType(char* value);
void GetScopeAddr(char* value);
void SetPositionerConfig(char* PositionerType,long int PositionerAddr);
void GetPositionerType(char* value);
long GetPositionerAddr();
void SetWaterConditionerPort(long int value);
long GetWaterConditionerPort();
void HydrophoneReadTXT(char* value);
int GetHydrophoneTabDataValid();
double GetHydrophoneDataPointX(long int index);
double GetHydrophoneDataPointY(long int index);
long GetHydrophoneTabDataCount();
double GetHydrophoneCalDate();
void GetScopeReference(char* value);
void SetScopeReference(char* value);
int GetScopeConnected();
int GetPositionerConnected();
long GetTempSensorPort();
void SetTempSensorPort(long int value);
double GetTempSensorTemperature();
void SetBeamAlignmentUseAngularPositioner(int value);
int GetBeamAlignmentUseAngularPositioner();
void SetAngPosInstalled(int value);
void Set3DScanRecordWaveforms(int value);
int Get3DScanRecordWaveforms();
void GetBeamAlignmentLastMessage(char* value);
void CopyZScanFcToSetupData();
void SetPositionerOvershoot(long int axis,double value);
double GetPositionerOvershoot(long int axis);
void SetPositionWindowVisible(int value);
int GetPositionWindowVisible();
long ShowPositionerOptionsDialog();
long ShowPositionerConfigDialog();
double GetXdcrPulsesPerScanLine();
void SetXdcrPulsesPerScanLine(double value);
double GetZXScanCalcResult(long int index);
long GetZScanCalcError();
long ZScanCalculate();
void SetWaveformUseCalcCenterFreq(int value);
int GetWaveformUseCalcCenterFreq();
void SetZScanUseCalcCenterFreq(int value);
int GetZScanUseCalcCenterFreq();
void SetZXScanUseCalcCenterFreq(int value);
int GetZXScanUseCalcCenterFreq();
int PositionerCheckConfig();
int PositionerCheckSprings();
long GetSoniqLoadSections();
void SetSoniqLoadSections(long int value);
int GetScopeMedianWF();
void SetScopeMedianWF(int value);
int LoadScopeSettings(char* value);
int SaveScopeSettings(char* value);
long GetBeamAlignmentPause();
void SetBeamAlignmentPause(long int value);
long GetSearchPlanePause();
void SetSearchPlanePause(long int value);
long GetSearchPause();
void SetSearchPause(long int value);
double GetAlignXAxisZDistance();
void SetAlignXAxisZDistance(double value);
double GetAlignXAxisXLength();
void SetAlignXAxisXLength(double value);
double GetAlignXAxisYLength();
void SetAlignXAxisYLength(double value);
long GetAlignXAxisPoints();
void SetAlignXAxisPoints(long int value);
long GetAlignXAxisPause();
void SetAlignXAxisPause(long int value);
long StartAlignX();
long GetFindWidthAxis();
void SetFindWidthAxis(long int value);
double GetFindWidthMaxDistance();
void SetFindWidthMaxDistance(double value);
double GetFindWidthIncrement();
void SetFindWidthIncrement(double value);
double GetFindWidthdBLevel();
void SetFindWidthdBLevel(double value);
long GetFindWidthPause();
void SetFindWidthPause(long int value);
long StartFindWidth();
double GetFindWidthWidth();
int GetFindWidthValid();
long GetFindPulsePause();
void SetFindPulsePause(long int value);
void SetFindPulseAutoScale(int value);
int GetFindPulseAutoScale();
void SetSearchAutoScale(int value);
int GetSearchAutoScale();
double GetSearchPlaneXStart();
double GetSearchPlaneXEnd();
double GetSearchPlaneXIncrement();
double GetSearchPlaneYStart();
double GetSearchPlaneYEnd();
double GetSearchPlaneYIncrement();
int GetSearchPlaneAutoScale();
void SetSearchPlaneXStart(double value);
void SetSearchPlaneXEnd(double value);
void SetSearchPlaneYStart(double value);
void SetSearchPlaneYEnd(double value);
void SetSearchPlaneAutoScale(int value);
void SetBeamAlignmentDoFinalCheck(int value);
int GetBeamAlignmentDoFinalCheck();
void SetBeamAlignmentPauseToChangeFocalZone(int value);
int GetBeamAlignmentPauseToChangeFocalZone();
void SetBeamAlignmentUseRMSataFreq(int value);
int GetBeamAlignmentUseRMSataFreq();
void SetFindWidthUseRMSataFreq(int value);
int GetFindWidthUseRMSataFreq();
void SetBeamAlignmentAutoScale(int value);
int GetBeamAlignmentAutoScale();
void SetAlignXAxisAutoScale(int value);
int GetAlignXAxisAutoScale();
void SetFindWidthAutoScale(int value);
int GetFindWidthAutoScale();
void SetBeamAlignmentdBLevel(double value);
double GetBeamAlignmentdBLevel();
void GetBeamAlignmentText(char* value);
void GetSearchPeakMode(char* Value);
void SetSearchPeakMode(char* Value);
void GetSearchPlanePeakMode(char* Value);
void SetSearchPlanePeakMode(char* Value);
void GetBeamAlignmentPeakMode(char* Value);
void SetBeamAlignmentPeakMode(char* Value);
void GetAlignXAxisPeakMode(char* Value);
void SetAlignXAxisPeakMode(char* Value);
void GetSearchAutoScaleMode(char* Value);
void SetSearchAutoScaleMode(char* Value);
void GetSearchPlaneAutoScaleMode(char* Value);
void SetSearchPlaneAutoScaleMode(char* Value);
void GetBeamAlignmentAutoScaleMode(char* Value);
void SetBeamAlignmentAutoScaleMode(char* Value);
void GetAlignXAxisAutoScaleMode(char* Value);
void SetAlignXAxisAutoScaleMode(char* Value);
void GetFindPulseAutoScaleMode(char* Value);
void SetFindPulseAutoScaleMode(char* Value);
void GetFindWidthAutoScaleMode(char* Value);
void SetFindWidthAutoScaleMode(char* Value);
void GetFreqScanAutoScaleMode(char* Value);
void SetFreqScanAutoScaleMode(char* Value);
void GetWaveformAutoScaleMode(char* Value);
void SetWaveformAutoScaleMode(char* Value);
void Get1DScanAutoScaleMode(char* Value);
void Set1DScanAutoScaleMode(char* Value);
void GetZScanAutoScaleMode(char* Value);
void SetZScanAutoScaleMode(char* Value);
void Get2DScanAutoScaleMode(char* Value);
void Set2DScanAutoScaleMode(char* Value);
void GetXYScanAutoScaleMode(char* Value);
void SetXYScanAutoScaleMode(char* Value);
void GetZXScanAutoScaleMode(char* Value);
void SetZXScanAutoScaleMode(char* Value);
void Get3DScanAutoScaleMode(char* Value);
void Set3DScanAutoScaleMode(char* Value);
long GetProgress();
long Start1DScanAsync();
long Start2DScanAsync();
void Cancel();
long Start3DScanAsync();
long StartFreqScanMeasAsync();
long StartFreqScanRefAsync();
long StartXYScanAsync();
long StartZScanAsync();
long StartZXScanAsync();
long StartBeamAlignmentAsync();
long StartFindpulseAsync();
long StartSearchPlaneAsync();
long StartSearchAsync();
long StartAlignXAxisAsync();
long StartFindWidthAsync();
void AddLogDataParameter(char* value);
void ClearLogData();
void ClearLogDataParameters();
double GetLogDataTimeIncrement();
long GetLogDataPoints();
double GetLogDataDuration();
void GetLogDataAutoScaleMode(char* value);
int GetLogDataRecordWaveforms();
int GetLogDataRealTimePlotting();
long GetLogDataSelected();
void GetLogDataViewMode(char* value);
double GetLogDataValue(long int index);
double GetLogDataTimeValue(long int index);
void SetLogDataTimeIncrement(double value);
void SetLogDataPoints(long int value);
void SetLogDataAutoScaleMode(char* value);
void SetLogDataRecordWaveforms(int value);
void SetLogDataRealTimePlotting(int value);
void SetLogDataSelected(long int value);
void SetLogDataViewMode(char* value);
long StartLogData();
long StartLogDataAsync();
void ClearData();
long GetLastResult();
long ReadIni(char* value);
void GetSoniqConfigPath(char* value);
void Get3DScanFileName(char* value);
void Set3DScanFileName(char* value);
void GetLastResultStr(char* value);
int GetSearchRealTimePlotting();
void SetSearchRealTimePlotting(int value);
int GetFindWidthRealTimePlotting();
void SetFindWidthRealTimePlotting(int value);
int GetWFWindowStopped();
void SetWFWindowStopped(int value);
long Get2DScanTotalPoints();
long GetXYScanTotalPoints();
long Get3DScanTotalPoints();
long GetBeamAlignmentTotalPoints();
long GetAlignXAxisTotalPoints();
long GetSearchPlaneTotalPoints();
long GetFindWidthPoints();
void SetFindWidthPoints(long int value);
long GetZXScanTotalPoints();
void ClearLastResult();
void SetXYScanCalcP1(int value);
void SetXYScanP1Factor(double value);
void SetXYScanCalcP1x1(int value);
void SetXYScanP1x1Factor(double value);
int GetXYScanCalcP1();
double GetXYScanP1Factor();
int GetXYScanCalcP1x1();
double GetXYScanP1x1Factor();
double GetXYScanP1();
double GetXYScanP1x1();
void Set2DScanCalcP1(int value);
void Set2DScanP1Factor(double value);
void Set2DScanCalcP1x1(int value);
void Set2DScanP1x1Factor(double value);
int Get2DScanCalcP1();
double Get2DScanP1Factor();
int Get2DScanCalcP1x1();
double Get2DScanP1x1Factor();
double Get2DScanP1();
double Get2DScanP1x1();
