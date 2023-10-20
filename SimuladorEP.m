function varargout = SimuladorEP(varargin)
% SIMULADOREP MATLAB code for SimuladorEP.fig
%      SIMULADOREP, by itself, creates a new SIMULADOREP or raises the existing
%      singleton*.
%
%      H = SIMULADOREP returns the handle to a new SIMULADOREP or the handle to
%      the existing singleton*.
%
%      SIMULADOREP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULADOREP.M with the given input arguments.
%
%      SIMULADOREP('Property','Value',...) creates a new SIMULADOREP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimuladorEP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimuladorEP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimuladorEP

% Last Modified by GUIDE v2.5 11-Mar-2022 20:57:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SimuladorEP_OpeningFcn, ...
    'gui_OutputFcn',  @SimuladorEP_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before SimuladorEP is made visible.
function SimuladorEP_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimuladorEP (see VARARGIN)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
%handles.porciento_outliers=0;
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
handles.medida=10^-6;
set(handles.ancho1,'String','')
set(handles.ancho2,'String','')
set(handles.M,'String','')
set(handles.Fs,'String','')
set(handles.tao,'String','')
set(handles.alfa,'String','')
set(handles.nfft,'String','')
set(handles.outlier1,'String','')
set(handles.outlier2,'String','')
set(handles.porciento_recorte,'String','')
set(handles.SNRmean,'String','');
set(handles.SNRtmean,'String','');
set(handles.SNRwmean,'String','');
set(handles.SNRwise,'String','');
set(handles.orden,'String','');
set(handles.SNRi,'String','' );
set(handles.porciento_outliers,'String','' );

% Choose default command line output for SimuladorEP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimuladorEP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SimuladorEP_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, ~, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in mean.
function mean_Callback(hObject, eventdata, handles)
% hObject    handle to mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mean

h=get(hObject,'Value');
if h==1
    t=1000.*(0:1/handles.Fs:length(handles.nmatrix_detrend(1,:))*1/handles.Fs-1/handles.Fs);
    snn_mean=mean(handles.nmatrix_detrend);
    snn_mean=snn_mean*handles.rang/range(snn_mean);
    axes(handles.axes5)
    plot(t,(snn_mean))
    xlabel('Tiempo (ms)');
    ylabel('Amplitud (V)');
    ax=gca;
    ax.XLim = [0 max(t)];
    ax.YLim = [-Inf Inf];
end
snreal=handles.smatrix3(1,:);
snreal_snr=snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snn_mean_snr=snn_mean((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snreal_snr=(snreal_snr-mean(snreal_snr))/std(snreal_snr);
snn_mean_snr=(snn_mean_snr-mean(snn_mean_snr))/std(snn_mean_snr);
ruido=(snn_mean_snr-snreal_snr);
snr_mean=10*log10(var(snreal_snr)/var(ruido));
bM=mean(abs(snn_mean-snreal));
%snr_mean=10*log10(var(snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1))/var(snn_mean((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)-snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)));
handles.snr_mean=snr_mean;
handles.snn_mean=snn_mean;
set(handles.SNRmean,'String',snr_mean);
guidata(hObject,handles);


% --- Executes on button press in tmean.
function tmean_Callback(hObject, eventdata, handles)
% hObject    handle to tmean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tmean

h=get(hObject,'Value');
if h==1
    t=1000.*(0:1/handles.Fs:length(handles.nmatrix_detrend(1,:))*1/handles.Fs-1/handles.Fs);
    snn_tmean=trimmean(handles.nmatrix_detrend, handles.porciento_recorte);
    snn_tmean=snn_tmean*handles.rang/range(snn_tmean);
    axes(handles.axes5)
    plot(t,(snn_tmean))
    xlabel('Tiempo (ms)');
    ylabel('Amplitud (V)');
    ax=gca;
    ax.XLim = [0 max(t)];
    ax.YLim = [-Inf Inf];
end
snreal=handles.smatrix3(1,:);
snreal_snr=snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snn_tmean_snr=snn_tmean((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snreal_snr=(snreal_snr-mean(snreal_snr))/std(snreal_snr);
snn_tmean_snr=(snn_tmean_snr-mean(snn_tmean_snr))/std(snn_tmean_snr);
ruido=(snn_tmean_snr-snreal_snr);
snr_mean=10*log10(var(snreal_snr)/var(ruido));
%snr_mean=10*log10(var(snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1))/var(snn_tmean((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)-snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)));
handles.snr_tmean=snr_mean;
handles.snn_tmean=snn_tmean;
set(handles.SNRtmean,'String',snr_mean);
guidata(hObject,handles);

% --- Executes on button press in wmean.
function wmean_Callback(hObject, eventdata, handles)
% hObject    handle to wmean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wmean

h=get(hObject,'Value');
if h==1
    t=1000.*(0:1/handles.Fs:length(handles.nmatrix_detrend(1,:))*1/handles.Fs-1/handles.Fs);
    [snn_wmean, y1,y2] = w_mean(handles.nmatrix_detrend);
    snn_wmean=snn_wmean*handles.rang/range(snn_wmean);
    axes(handles.axes5)
    %snn_wmean=1/10^-3.*snn_wmean;
    plot(t,(snn_wmean))
    xlabel('Tiempo (ms)');
    ylabel('Amplitud (V)');
    ax=gca;
    ax.XLim = [0 max(t)];
    ax.YLim = [-Inf Inf];
end
snreal=handles.smatrix3(1,:);
snreal_snr=snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snn_wmean_snr=snn_wmean((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snreal_snr=(snreal_snr-mean(snreal_snr))/std(snreal_snr);
snn_wmean_snr=(snn_wmean_snr-mean(snn_wmean_snr))/std(snn_wmean_snr);
ruido=(snn_wmean_snr-snreal_snr);
snr_mean=10*log10(var(snreal_snr)/var(ruido));
%snr_mean=10*log10(var(snreal)/var(snn_wmean-snreal));
%snr_mean=10*log10(var(snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1))/var(snn_wmean((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)-snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)));
handles.snr_wmean=snr_mean;
handles.snn_wmean=snn_wmean;
set(handles.SNRwmean,'String',snr_mean);
guidata(hObject,handles);

% --- Executes on button press in wise.
function wise_Callback(hObject, eventdata, handles)
% hObject    handle to wise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wise

h=get(hObject,'Value');
if h==1
    t=1000.*(0:1/handles.Fs:length(handles.nmatrix_detrend(1,:))*1/handles.Fs-1/handles.Fs);
    [r,c]=size(handles.nmatrix_detrend);
    [snn_wise,d,m,w]=modtrim_MAD(handles.nmatrix_detrend);
     snn_wise=snn_wise*handles.rang/range(snn_wise);
    axes(handles.axes5)
    plot(t,(snn_wise),'LineWidth',1.5)
    xlabel('Tiempo (ms)');
    ylabel('Amplitud (V)');
    ax=gca;
    ax.XLim = [0 max(t)];
    ax.YLim = [-Inf Inf];
end
snreal=handles.smatrix3(1,:);
%snreal=mean(handles.smatrix);
% snreal=(snreal-mean(snreal))/std(snreal);
% snn_wise=(snn_wise-mean(snn_wise))/std(snn_wise);
% if size(snn_wise, 1)==size(snreal,1)
%     snr_mean=10*log10(var(snreal)/var(snn_wise-snreal));
% else
%     snr_mean=10*log10(var(snreal)/var(snn_wise'-snreal));
% end
snreal_snr=snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snn_wise_snr=snn_wise((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1);
snreal_snr=(snreal_snr-mean(snreal_snr))/std(snreal_snr);
snn_wise_snr=(snn_wise_snr-mean(snn_wise_snr))/std(snn_wise_snr);
ruido=(snn_wise_snr-snreal_snr);
snr_mean=10*log10(var(snreal_snr)/var(ruido));
%snr_mean=10*log10(var(snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1))/var(snn_wise((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)-snreal((length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+1:(length(handles.smatrix3)-(handles.ancho2-handles.ancho1))/2+handles.ancho2-handles.ancho1)));
handles.snr_wise=snr_mean;
handles.snn_wise=snn_wise;
set(handles.SNRwise,'String',snr_mean);
guidata(hObject,handles);


function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M as text
%        str2double(get(hObject,'String')) returns contents of M as a double

Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=512;
end
handles.M=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tao_Callback(hObject, eventdata, handles)
% hObject    handle to tao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tao as text
%        str2double(get(hObject,'String')) returns contents of tao as a double

Val=get(hObject,'String');
NewVal=str2double(Val);
NewVal=((0 + (NewVal*10^-3 - 0).*randn(1,1)));
%NewVal = NewVal*10^-3.*randn(1,1) + 0;
if isnan(NewVal)
    %r = a + (b-a).*rand(N,1).
    %NewVal = 0.2*10^-3.*randn(1,1) + 0;
    NewVal=((0 + (0.0002 -0).*randn(1,1)));
end
handles.tao=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function tao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function alfa_Callback(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfa as text
%        str2double(get(hObject,'String')) returns contents of alfa as a double

Val=get(hObject,'String');
NewVal=str2double(Val);
NewVal=((0 + (NewVal*10^-3 -0).*rand(1,1)));
%NewVal = NewVal*10^-3.*randn(1,1) + 0;
if isnan(NewVal)
    %NewVal = 0.0713*10^-3.*randn(1,1) + 0;
    NewVal=((0 + (0.0713*10^-3-0).*rand(1,1)));
end
handles.alfa=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Fs_Callback(hObject, eventdata, handles)
% hObject    handle to Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fs as text
%        str2double(get(hObject,'String')) returns contents of Fs as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=handles.fs1;
end
handles.Fs=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nfft_Callback(hObject, eventdata, handles)
% hObject    handle to nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nfft as text
%        str2double(get(hObject,'String')) returns contents of nfft as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=1024;
end
handles.nfft=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nfft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ancho1_Callback(hObject, eventdata, handles)
% hObject    handle to ancho1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ancho1 as text
%        str2double(get(hObject,'String')) returns contents of ancho1 as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=1;
end
handles.ancho1=round(NewVal/1000*handles.fs1); %para llevarlo a muestra
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ancho1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ancho2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.

function outlier2_Callback(hObject, eventdata, handles)
% hObject    handle to outlier2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outlier2 as text
%        str2double(get(hObject,'String')) returns contents of outlier2 as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=0;
end
handles.outlier2=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function outlier2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outlier2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function edit21_Callback(hObject, eventdata, handles)
% % hObject    handle to porciento_outliers (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hints: get(hObject,'String') returns contents of porciento_outliers as text
% %        str2double(get(hObject,'String')) returns contents of porciento_outliers as a double
% Val=get(hObject,'String');
% NewVal=str2double(Val)/100;
% if isnan(NewVal)
%     NewVal=0;
% end
% handles.porciento_outliers=NewVal;
% guidata(hObject,handles);
%
%
%
% % --- Executes during object creation, after setting all properties.
% function edit21_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to porciento_outliers (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
%
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function outlier1_Callback(hObject, eventdata, handles)
% hObject    handle to outlier1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outlier1 as text
%        str2double(get(hObject,'String')) returns contents of outlier1 as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=0;
end
handles.outlier1=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function outlier1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outlier1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in medida.
function medida_Callback(hObject, eventdata, handles)
% hObject    handle to medida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns medida contents as cell array
%        contents{get(hObject,'Value')} returns selected item from medida
fun=get(hObject,'Value');
switch fun
    case 1
        handles.medida=10^-6;
    case 2
        handles.medida=10^-3;
    case 3
        handles.medida=1;
        
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function medida_CreateFcn(hObject, eventdata, handles)
% hObject    handle to medida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uitoolbar5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitoolbar5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --------------------------------------------------------------------
function uipushtool6_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get(hObject,'Value')
[inputname, inputpath] = uigetfile('*.dat*', 'Load dataset', 'MultiSelect','off');
[signal,Fs,tm]=rdsamp(inputname);
get(hObject,'Value')
% --- Cargar las interferencias de 60 Hz
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa

load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
guidata(hObject,handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB

[inputname, inputpath] = uigetfile({'*.dat;*.mat;*.abr'}, 'Load dataset', 'MultiSelect','off');
if strcmp(inputname(end-2:end),'dat')
    [signal,fs,tm]=rdsamp(inputname);
    signalABR=signal(:,1); % Para escoger una seal promedio
    inputname_name=[inputname(1:2),' ',inputname(11:13),' ',inputname(14:16),'dB SPL'];
    % Convierto a  milivolt .
    signalABR=signalABR*10^-25/2;
    snn=signalABR(1:884);
    t=(0:1/fs:length(snn)*1/fs-1/fs)'.*1000;
elseif strcmp(inputname(end-2:end),'mat')
    snn=load(inputname);
elseif strcmp(inputname(end-2:end),'abr')
    snn = readerEd([inputpath,inputname]);
end
handles.snn=snn;
handles.t=t;
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
axes(handles.axes1)
plot(t,1/10^-6.*snn)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo (ms)')
ylabel('Amplitud (V)')

guidata(hObject,handles);
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7



function orden_Callback(hObject, eventdata, handles)
% hObject    handle to orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of orden as text
%        str2double(get(hObject,'String')) returns contents of orden as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=5;
end
handles.orden=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function orden_CreateFcn(hObject, eventdata, handles)
% hObject    handle to orden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

% --- Executes during object deletion, before destroying properties.
function axes1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Fichero_Callback(hObject, eventdata, handles)
% hObject    handle to Fichero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Editar_Callback(hObject, eventdata, handles)
% hObject    handle to Editar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Herramientas_Callback(hObject, eventdata, handles)
% hObject    handle to Herramientas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Ayuda_Callback(hObject, eventdata, handles)
% hObject    handle to Ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cargar_senal_Callback(hObject, eventdata, handles)
% hObject    handle to cargar_senal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axes4)
cla(handles.axes5)
set(handles.ancho1,'String','')
set(handles.ancho2,'String','')
set(handles.M,'String','')
set(handles.Fs,'String','')
set(handles.tao,'String','')
set(handles.alfa,'String','')
set(handles.nfft,'String','')
set(handles.outlier1,'String','')
set(handles.outlier2,'String','')
set(handles.porciento_recorte,'String','')
set(handles.SNRmean,'String','');
set(handles.SNRtmean,'String','');
set(handles.SNRwmean,'String','');
set(handles.SNRwise,'String','');
set(handles.orden,'String','');
set(handles.SNRi,'String','' );
set(handles.porciento_outliers,'String','' );


[inputname, inputpath] = uigetfile({'*.dat;*.mat;*.abr'}, 'Load dataset', 'MultiSelect','off');
if strcmp(inputname(end-2:end),'dat')
    [signal,fs,~]=rdsamp(inputname);
    signalABR=signal(:,1); % Para escoger una seal promedio
    inputname_name=[inputname(1:2),' ',inputname(11:13),' ',inputname(14:16),'dB SPL'];
    % Convierto a  microvolt .
    signalABR=signalABR*10^-25/2;
    snn1=signalABR;
    %snn=signalABR(1:884);
    t=(0:1/fs:length(snn1)*1/fs-1/fs)'.*1000;
elseif strcmp(inputname(end-2:end),'mat')
    snn1=load(inputname);
elseif strcmp(inputname(end-2:end),'ABR')
    snn1 = readerEd([inputpath,inputname]);
    N=200;
    fs=200/0.015;
    snn1=snn1*0.0130412106712659; %para llevarlo a unidades de medidas fsicas
    %Conformar la matriz conjunto
    [signal_audix, signalPar, signalImpar]=PromABRmio(snn1,N);
    matrix_conjunto=signal_audix;
    matrix_conjunto_par=signalPar;
    matrix_conjunto_impar=signalImpar;
    snn1=mean(signal_audix);
    snn1=(snn1-mean(snn1))/std(snn1);
    snn1=snn1/10;
    t=(0:1/fs:length(snn1)*1/fs-1/fs)'.*1000;
end
snn1=resample(snn1,720,720);
handles.fs1=fs;
handles.inputname=inputname;
handles.snn1=snn1;
handles.t=t;
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
axes(handles.axes1)
if strcmp(inputname(end-2:end),'dat')
    plot(t,1/10^-6.*snn1)
elseif strcmp(inputname(end-2:end),'mat')
    plot(t,1/10^-6.*snn1)
elseif strcmp(inputname(end-2:end),'ABR')
    plot(t,snn1)
end
axis([0 max(t) -Inf Inf])
xlabel('Tiempo (ms)')
ylabel('Amplitud (V)')
handles.direccion=strcat(inputpath,inputname);
guidata(hObject,handles);

% --------------------------------------------------------------------
function cargar_ondaconocida_Callback(hObject, eventdata, handles)
% hObject    handle to cargar_ondaconocida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function salvar_senal_Callback(hObject, eventdata, handles)
% hObject    handle to salvar_senal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function haar_Callback(hObject, eventdata, handles)
% hObject    handle to haar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function db_Callback(hObject, eventdata, handles)
% hObject    handle to db (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sym_Callback(hObject, eventdata, handles)
% hObject    handle to sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function coif_Callback(hObject, eventdata, handles)
% hObject    handle to coif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gaus_Callback(hObject, eventdata, handles)
% hObject    handle to gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function meyr_Callback(hObject, eventdata, handles)
% hObject    handle to meyr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;

[phi,snn,xval] = wavefun('meyr',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.xval=xval;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
close handles.axes1
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function morl_Callback(hObject, eventdata, handles)
% hObject    handle to morl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,xval] = wavefun('morl',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.xval=xval;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);
% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, eventdata, handles)
% hObject    handle to orden1gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function orden2gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden2gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus2',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function Untitled_36_Callback(hObject, eventdata, handles)
% hObject    handle to orden3gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_37_Callback(hObject, eventdata, handles)
% hObject    handle to orden4gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_38_Callback(hObject, eventdata, handles)
% hObject    handle to orden5gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_39_Callback(hObject, eventdata, handles)
% hObject    handle to orden6gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_40_Callback(hObject, eventdata, handles)
% hObject    handle to orden7gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_41_Callback(hObject, eventdata, handles)
% hObject    handle to orden8gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_29_Callback(hObject, eventdata, ~)
% hObject    handle to orden1gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
% hObject    handle to orden2gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
% hObject    handle to orden3gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_32_Callback(hObject, eventdata, handles)
% hObject    handle to orden4gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)
% hObject    handle to orden5gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to orden1gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to orden2gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to orden3gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to orden4gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_25_Callback(hObject, eventdata, handles)
% hObject    handle to orden5gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
% hObject    handle to orden6gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
% hObject    handle to orden7gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to orden8gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function orden1gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden1gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus1',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden3gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden3gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus3',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);
% --------------------------------------------------------------------
function orden4gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden4gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus4',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden5gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden5gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus5',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden6gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden6gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus6',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden7gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden7gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus7',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden8gaus_Callback(hObject, eventdata, handles)
% hObject    handle to orden8gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[snn,~] = wavefun('gaus8',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden9_Callback(hObject, eventdata, handles)
% hObject    handle to orden9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db9',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);
% --------------------------------------------------------------------
function orden10_Callback(hObject, eventdata, handles)
% hObject    handle to orden10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db10',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);


% --------------------------------------------------------------------
function orden1coif_Callback(hObject, eventdata, handles)
% hObject    handle to orden1coif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('coif1',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden2coif_Callback(hObject, eventdata, handles)
% hObject    handle to orden2coif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('coif2',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden3coif_Callback(hObject, eventdata, handles)
% hObject    handle to orden3coif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('coif3',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);
% --------------------------------------------------------------------
function orden4coif_Callback(hObject, eventdata, handles)
% hObject    handle to orden4coif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('coif4',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden5coif_Callback(hObject, eventdata, handles)
% hObject    handle to orden5coif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('coif5',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);
% --------------------------------------------------------------------
function orden1sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden1sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym1',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden2sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden2sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym2',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden3sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden3sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym3',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (u)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden4sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden4sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym4',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden5sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden5sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym5',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden6sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden6sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym6',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden7sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden7sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym7',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);
% --------------------------------------------------------------------
function orden8sym_Callback(hObject, eventdata, handles)
% hObject    handle to orden8sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('sym8',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden1_Callback(hObject, eventdata, handles)
% hObject    handle to orden1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db1',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden2_Callback(hObject, eventdata, handles)
% hObject    handle to orden2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db2',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);


% --------------------------------------------------------------------
function orden3_Callback(hObject, eventdata, handles)
% hObject    handle to orden3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db3',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden4_Callback(hObject, eventdata, handles)
% hObject    handle to orden4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db4',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden5_Callback(hObject, eventdata, handles)
% hObject    handle to orden5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db5',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden6_Callback(hObject, eventdata, handles)
% hObject    handle to orden6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db6',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden7_Callback(hObject, eventdata, handles)
% hObject    handle to orden7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db7',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=48000/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);

% --------------------------------------------------------------------
function orden8_Callback(hObject, eventdata, handles)
% hObject    handle to orden8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
[phi,snn,~] = wavefun('db8',11);
% 18 ms de seal
ts=0.018/length(snn);
fs=1/ts;
factor=handles.Fs/fs;
factor=rats(factor);
[~,b]=find(factor=='/');
p=str2double(factor(2:b-1));
q=str2double(factor(b+1:end-1));
snn1 = resample(snn,p,q);
snn1=5.0000e-7*snn1;
fs1=p/q*fs;
t=(0:1/fs1:length(snn1)*1/fs1-1/fs1).*1000;
handles.phi=phi;
handles.snn1=snn1;
handles.fs1=fs1;
handles.t=t;% para llevarlo a milisegundo
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo(ms)')
ylabel('Amplitud (V)')
guidata(hObject,handles);


% --- Executes on button press in simular.
function simular_Callback(hObject, eventdata, handles)
% hObject    handle to simular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axes4)
cla(handles.axes5)

snn1=handles.snn1(handles.ancho1:handles.ancho2);
snn1=snn1-mean(snn1);

%para hacer comparacin
snn3=detrend(snn1,'linear');
handles.snn3=snn3;

A=(max(snn1)-min(snn1)/2);
fs=handles.Fs/(720/720);
fstim=1; % 24Hz about 41.7 ms per trial, at a presentation rate of about 24 Hz
per=1/fstim; % el periodo relativo del evento depende de la frecuencia de estimulacin
M=handles.M;
aml='randn';
wml='randn';
pml='randn';
pam=((0 + (0.2+0).*rand(1,1)));
pwm=handles.alfa;
ppm=handles.tao;
w0=[0,(1/fs*size(snn1,1))];
pp='c'; % c si es el centro de la forma de onda, y 'o' si es el comienzo
nb=32;
Amax=20*A;%20*A; %maximun value that can be converted by the ADC, hasta 10 V
os=4; %oversampling factor to get the 'continuos' waveforms
%           (signals are oversampled at 2^os times), default value is os=4
if  isfield(handles,'inputname')
    handles.snn2=handles.snn1(handles.ancho1:handles.ancho2);
else
    handles.snn2=handles.snn1(handles.ancho1:handles.ancho2);
end
[svector,smatrix,refm,rsa,lsa,amplits,widths,delays,fs,nb,Amax] = ...
    avetestsignal2('other',handles.snn2,A,handles.Fs,per,M,aml,pam,wml,pwm,pml,ppm,pp,nb,Amax,os);

[svector3,smatrix3,refm3,rsa3,lsa3,amplits3,widths3,delays3,fs3,nb3,Amax3] = ...
    avetestsignal2('other',handles.snn3,A,handles.Fs,per,M,aml,pam,wml,pwm,pml,ppm,pp,nb,Amax,os);
rang=range(smatrix3(1,:));
handles.smatrix=smatrix;
handles.svector=svector;
handles.smatrix3=smatrix3;
handles.rang=rang;

%Otras interferencias
if  isfield(handles,'inputname')
    if handles.inputname(2)=='1'
        v=1;
        %Para escoger aleatoriamente una de las matrices de interferencia
        j=randi(24);
    elseif handles.inputname(2)=='4'
        v=2;
        j=randi([25,39]);
    elseif handles.inputname(2)=='5'
        v=3;
        j=randi([40,54]);
    elseif handles.inputname(2)=='6'
        v=4;
        j=randi([55,70]);
        if j==66||63
            j=55;
        end
    elseif handles.inputname(2)=='7'
        v=5;
        j=randi([71,86]);
    elseif handles.inputname(2)=='8'
        v=6;
        j=randi([87,102]);
    elseif handles.inputname(2)=='0'
        v=randi([1,6]);
        j=randi([1,102]);
        if j==66||63
            j=55;
        end
    end
else
    v=randi([1,6]);
    j=randi([1,102]);
    if j==66||63
        j=55;
    end
end
inter=handles.interf(:,:,j);
dif_cero=inter~=0;
diff_cero=sum(dif_cero);
inter1=inter(1:diff_cero(1),:);
inter1=inter1(2:end,:);
inter_alfa=inter1(1,:);
inter1((inter1(:,1)<1)==0);
% Para el ruido coloreado
colorn=[3, 1, [30 3000], 500*std(svector),3]; %1000*std(svector)
% ruido alpha
if inter_alfa(1,1)>1
    inter_alfa(1,1)=30*10^-6; % 30uV siguiendo leonowics
end

[r1, c1]=size(smatrix);
%alfa=randn(1,length(svector));

alfamean = (0.00005-0.00003).*rand(1,1) + 0.00003;
alfa=alfamean.*randn(1,length(svector)+10000)+0.00004;
%alfa = (std(svector)+std(svector)).*randn(1,length(svector)+10000)+(std(svector));% + 250*10^-6;
% %vnoise1=alpha_filt;
% p=round(0.20*r1);% por ciento de ruido alpha
% alfa_pos=randperm(r1);
% alfa_pos=alfa_pos(1,1:p);
% for i=1:p
% vnoise1(1,2048*alfa_pos(i):2048*alfa_pos(i)+c1-1)=alfa;%2048*(i-1)+1:2048*i
% end
vnoise1=filtfilt(handles.SOS_PA,handles.G_PA,alfa);
vnoise1= filtfilt(handles.SOS_PB,handles.G_PB,vnoise1);
vnoise1=vnoise1(5001:end-5000);

vimpulse= zeros(1,length(handles.svector));
if isnumeric (handles.porciento_outliers)
    porciento_outliers=handles.porciento_outliers;
    a = handles.outlier1*handles.medida;
    b = handles.outlier2*handles.medida;
    l=length(vnoise1);
    artefacto=zeros(1,l);
    magartpos=(a + (b-a).*rand(1,l));
    magartneg=(-b + (-a+b).*rand(1,l));
    art=cat(2,magartpos, magartneg);
    num=round(handles.porciento_outliers*length(handles.svector));
    num1=randperm(2*l);
    art1=art(num1);
    art2=art1(num1(1:num));
    artefacto(1:num)=art2;
    num2=randperm(l);
    artefacto=artefacto(num2);
    
    vimpulse=artefacto;
    handles.vimpulse=vimpulse;
    [nvector,nmatrix,snr] = avetestnoise2(svector,handles.Fs,nb,Amax,refm,rsa,lsa,inter1,colorn,vnoise1,handles.vimpulse,j,v);
else
    porciento_outliers=get(handles.porciento_outliers,'String');
    porciento_outliers=str2double(porciento_outliers);
    if isnan(porciento_outliers)
        vimpulse= zeros(1,length(handles.svector));
        handles.vimpulse=vimpulse;
        [nvector,nmatrix,snr] = avetestnoise2(svector,handles.Fs,nb,Amax,refm,rsa,lsa,inter1,colorn,vnoise1,handles.vimpulse,j,v);      
    end
end
% handles.vimpulse=vimpulse;
% [nvector,nmatrix,snr] = avetestnoise2(svector,handles.Fs,nb,Amax,refm,rsa,lsa,inter1,colorn,vnoise1,handles.vimpulse,j,v);
% nmatrix_DC = detrend(nmatrix','constant');
% nmatrix_DC=nmatrix_DC';
% nmatrix_detrend=nmatrix_DC;
%handles.nmatrix_detrend=nmatrix_detrend;
handles.nmatrix=nmatrix;
handles.svector=svector;
handles.nb=nb;
handles.Amax=Amax;
handles.refm=refm;
handles.rsa=rsa;
handles.lsa=lsa;
handles.inter1=inter1;
handles.colorn=colorn;
handles.vnoise1=vnoise1;
handles.vimpulse=vimpulse;
handles.j=j;
handles.v=v;
handles.nmatrix=nmatrix;

set(handles.SNRi,'String',snr);

axes(handles.axes2)
t=1/10^-3.*(0:1/handles.Fs:size(smatrix,2)*1/handles.Fs-1/handles.Fs);
smatrix1=1/10^-6.*smatrix;
mesh(t,1:M,smatrix1)
shading flat
colormap(bone)
ax=gca;
ax.XLim = [0 max(t)];
ax.YLim = [0 M];
ax.ZLim = [-Inf Inf];
xlabel('Tiempo (ms)');
ylabel('Nmero de pocas');
zlabel('Amplitud (V)');

axes(handles.axes3)
mesh(t,1:M,1/10^-6.*nmatrix);
hold on
surf(t,1:M,1/10^-6.*smatrix,'LineWidth',5);
%shading flat
colormap(bone)
hold off
handles.t=t;
ax=gca;
ax.XLim = [0 max(t)];
ax.YLim = [0 M];
ax.ZLim = [-Inf Inf];

xlabel('Tiempo (ms)');
ylabel('Nmero de pocas');
zlabel('Amplitud (V)');

[pxx2,w2] = pwelch(nvector/std(nvector),10*handles.nfft);
axes(handles.axes4)
plot((w2*handles.Fs)/(2*pi),pow2db(pxx2)); %  pow2db ydb = 10 log10(y). lleva a dB
axis([0 handles.Fs/2 -Inf Inf])
ax = gca;
%cax=ax.XScale;
ax.XScale='log';
xlabel('Frecuencia(Hz)')
ylabel('Magnitud (dB)')

axes(handles.axes5)
%smatrix(1,:)=detrend(smatrix(1,:),687, 1034);
plot(t,(smatrix3(1,:)),'k','LineWidth',3)
%plot(t,1/10^-6.*smatrix(1,:),'k','LineWidth',3)
hold on
snmean=mean(handles.nmatrix);
plot(t,(snmean))
%plot(t,1/10^-6.*mean(handles.nmatrix_detrend));
hold off
xlabel('Tiempo (ms)');
ylabel('Amplitud (V)');
ax=gca;
ax.XLim = [0 max(t)];
ax.YLim = [-Inf Inf];
hold on



guidata(hObject,handles);

% --- Executes on button press in add_outliers.
function add_outliers_Callback(hObject, eventdata, handles)
% hObject    handle to add_outliers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vimpulse= zeros(1,length(handles.svector));
if isfield(handles, 'medida')==0
    handles.medida=10^-6;
else
    if handles.porciento_outliers==0
        vimpulse= vimpulse;
    else
        a = handles.outlier1*handles.medida;
        b = handles.outlier2*handles.medida;
        l=length(vimpulse);
        artefacto=zeros(1,l);
        magartpos=(a + (b-a).*rand(1,l));
        magartneg=(-b + (-a+b).*rand(1,l));
        art=cat(2,magartpos, magartneg);
        num=round(handles.porciento_outliers*length(handles.svector));
        num1=randperm(2*l);
        art1=art(num1);
        art2=art1(num1(1:num));
        artefacto(1:num)=art2;
        num2=randperm(l);
        artefacto=artefacto(num2);
        
        vimpulse=artefacto;
    end
end
handles.vimpulse=vimpulse;
%vnoise1=vnoise+artefacto;
[nvector,nmatrix,snr] = avetestnoise2(handles.svector,handles.Fs,handles.nb,handles.Amax,handles.refm,handles.rsa,handles.lsa,handles.inter1,handles.colorn,handles.vnoise1,vimpulse,handles.j,handles.v);

handles.nmatrix=nmatrix;

cla(handles.axes3)
axes(handles.axes3)
t=handles.t;
M=handles.M;
mesh(t,1:M,1/10^-6.*nmatrix)

hold on
surf(t,1:M,1/10^-6.*handles.smatrix,'LineWidth',5);
%shading flat
colormap(bone)
hold off
handles.t=t;
ax=gca;
ax.XLim = [0 max(t)];
ax.YLim = [0 M];
ax.ZLim = [-Inf Inf];

xlabel('Tiempo (ms)');
ylabel('Nmero de pocas');
zlabel('Amplitud (V)');
set(handles.SNRi,'String',snr);
guidata(hObject,handles);


function ancho2_Callback(hObject, eventdata, handles)
% hObject    handle to ancho2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ancho2 as text
%        str2double(get(hObject,'String')) returns contents of ancho2 as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=length(handles.snn1);
end
handles.ancho2=round(NewVal/1000*handles.fs1);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ancho2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ancho2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function detrending_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ancho2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in uno.
function uno_Callback(hObject, eventdata, handles)
% hObject    handle to uno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uno
uno=get(hObject,'Value');
if uno==1
    [r,c]=size(handles.nmatrix);
    handles.nmatrix_detrend=zeros(r,c);
    nmatrix_DC = detrend(handles.nmatrix','constant');
    nmatrix_DC=nmatrix_DC';
    nmatrix_detrend=nmatrix_DC;
    handles.nmatrix_detrend=nmatrix_detrend;
end
handles.uno=uno;
guidata(hObject,handles)

% --- Executes on button press in dos.
function dos_Callback(hObject, eventdata, handles)
% hObject    handle to dos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dos
h=get(hObject,'Value');
      if h==1
    [r,c]=size(handles.nmatrix);
    handles.nmatrix_detrend=zeros(r,c);
    nmatrix_TL = detrend(handles.nmatrix','linear', round(c/10));
    nmatrix_TL=nmatrix_TL';
    nmatrix_detrend=nmatrix_TL;
    handles.nmatrix_detrend=nmatrix_detrend;
end
guidata(hObject,handles)

% --- Executes on button press in tres.
function tres_Callback(hObject, eventdata, handles)
% hObject    handle to tres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tres
h=get(hObject,'Value');
if h==1
    [r,c]=size(handles.nmatrix);
    handles.nmatrix_detrend=zeros(r,c);
    t=1/10^-3.*(0:1/handles.Fs:size(handles.smatrix,2)*1/handles.Fs-1/handles.Fs);
    %     Val=get(handles.orden,'String');
    %     NewVal=str2double(Val);
    %     if isnan(NewVal)
    %        handles.orden=5;
    %     end
    for i=1:r
        [f(i,:),~,mu] = polyfit(t,handles.nmatrix(i,:),handles.orden);
        out_y(i,:)=polyval(f(i,:),t,[],mu);
    end
    nmatrix_MP=handles.nmatrix-out_y;
    nmatrix_detrend=nmatrix_MP;
    handles.nmatrix_detrend=nmatrix_detrend;
end
guidata(hObject,handles)
% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, ~, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes when selected object is changed in detrending.
function detrending_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in detrending
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (hObject==handles.uno)
    nmatrix_DC = detrend(handles.nmatrix','constant');
    nmatrix_DC=nmatrix_DC';
    nmatrix_detrend=nmatrix_DC;
    handles.nmatrix_detrend=nmatrix_detrend;
elseif (hObject==handles.dos)
    [r,c]=handles.nmatrix;
    nmatrix_TL = detrend(handles.nmatrix','linear', round(c/3));
    nmatrix_TL=nmatrix_TL';
    nmatrix_detrend=nmatrix_TL;
    handles.nmatrix_detrend=nmatrix_detrend;
elseif (hObject==handles.tres)
    [r,c]=size(handles.nmatrix);
    t=1/10^-3.*(0:1/handles.Fs:size(handles.smatrix,2)*1/handles.Fs-1/handles.Fs);
    for i=1:r
        [f(i,:),~,mu] = polyfit(t,handles.nmatrix(i,:),handles.orden);
        out_y(i,:)=polyval(f(i,:),handles.t,[],mu);
    end
    nmatrix_MP=handles.nmatrix-out_y;
    nmatrix_detrend=nmatrix_MP;
    handles.nmatrix_detrend=nmatrix_detrend;
end
guidata(hObject,handles);


% --- Executes when uipanel4 is resized.
function uipanel4_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function uipanel4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% function porciento_outliers_Callback(hObject, eventdata, handles)
% % hObject    handle to porciento_outliers (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hints: get(hObject,'String') returns contents of porciento_outliers as text
% %        str2double(get(hObject,'String')) returns contents of porciento_outliers as a double
% Val=get(hObject,'String');
% NewVal=str2double(Val);
% if isnan(NewVal)
%     NewVal=0;
% end
% handles.porciento_outliers=NewVal/100;
% guidata(hObject,handles);
%
% % --- Executes during object creation, after setting all properties.
% function porciento_outliers_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to porciento_outliers (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
%
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function porciento_recorte_Callback(hObject, eventdata, handles)
% hObject    handle to porciento_recorte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of porciento_recorte as text
%        str2double(get(hObject,'String')) returns contents of porciento_recorte as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=5;
end
handles.porciento_recorte=NewVal;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function porciento_recorte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to porciento_recorte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function axes2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in metodosPromedio.
function metodosPromedio_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in metodosPromedio
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes on mouse press over axes background.
function axes5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool9_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to cargar_senal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load interf % cargar las interferencias
load Hd_alpha % para generar ruido alfa
load SOS_PA
load G_PA
load SOS_PB
load G_PB
cla(handles.axes2)
cla(handles.axes3)
cla(handles.axes4)
cla(handles.axes5)

[inputname, inputpath] = uigetfile({'*.dat;*.mat;*.abr'}, 'Load dataset', 'MultiSelect','off');
if strcmp(inputname(end-2:end),'dat')
    [signal,fs,~]=rdsamp(inputname);
    signalABR=signal(:,1); % Para escoger una seal promedio
    inputname_name=[inputname(1:2),' ',inputname(11:13),' ',inputname(14:16),'dB SPL'];
    % Convierto a  milivolt .
    signalABR=signalABR*10^-25/2;
    snn1=signalABR;
    %snn=signalABR(1:884);
    t=(0:1/fs:length(snn1)*1/fs-1/fs)'.*1000;
elseif strcmp(inputname(end-2:end),'mat')
    snn1=load(inputname);
elseif strcmp(inputname(end-2:end),'abr')
    snn1 = readerEd([inputpath,inputname]);
end
handles.fs1=fs;
handles.inputname=inputname;
handles.snn1=snn1;
handles.t=t;
handles.interf=interf;
handles.Hd_alpha=Hd_alpha;
handles.SOS_PA=SOS_PA;
handles.G_PA=G_PA;
handles.SOS_PB=SOS_PB;
handles.G_PB=G_PB;
axes(handles.axes1)
plot(t,1/10^-6.*snn1)
axis([0 max(t) -Inf Inf])
xlabel('Tiempo (ms)')
ylabel('Amplitud (V)')
handles.direccion=strcat(inputpath,inputname);
guidata(hObject,handles);


% --------------------------------------------------------------------
function uitoggletool15_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool14_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotedit


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Fichero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'En el panel Forma de onda bsica se visualizar la forma de onda bsica escogida con sus unidades de medidas fsicas correspondientes', 'La simulacin parte de una forma de onda bsica, xo(t), de la que se obtienen versiones desplazadas (a la derecha o la izquierda), contradas o dilatadas y con variaciones en la amplitud, las cuales son modificadas en el panel de Especificaciones para la simulacin'},'Forma de onda bsica')

% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

helpdlg({'En el panel de Especificaciones para la simulacin','a: corresponde a los valores inicial y final de la ventana de anlisis, dado en ms','M: nmero de pocas o potenciales que poseer el registro completo',...
    'tao: El parmetro tao corresponde a la variacin de los desplazamientos relativos debido a la latencia que puede estar presente en  xo(t), se simula siguiendo una ley de variacin normal con media cero y desviacin estndar del orden tao ms',...
    'alfa: El parmetro alfa, correspondiente a la variacin del ancho de xo(t), se simula siguiendo una ley de variacin normal con media cero y desviacin estndar del orden de alfa ms',...
    'Fs: corresponde a la Frecuencia de muestreo','NFFT: corresponde al nmero de puntos para estimar es espectro de la seal simulada','Al simular los registros es adicionado ruido aditivo n(t), que ha sido estimado a partir del analisis de ruidos de fondo de registros EEG, ms las interferencias de 60 Hz y sus armnicos, ms ritmo alfa que se encuentra presente en muchas de las seales de diferentes bases de datos sobre el tema',...
    'A la simulacin se le puede adicionar ruido del tipo impulsivo (outliers), las especificaciones para este tipo de ruido se encuentran en el Panel Ruido Impulsivo'},'Especificaciones para la simulacin')
% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'A la simulacin se le puede adicionar ruido del tipo impulsivo (outliers)','En % de pocas contaminadas se especfica el por ciento del total de pocas que poseern este tipo de ruido',...
    'En rango de amplitudes, los valores mnimo y mximo de estos impulsos, segn la unidad de medida especificado en Unidades', 'Los impulsos, sus posiciones amplitudes y signos son aleatoriamente distribuidos con una distribucin uniforme',...
    'Luego de adicionar ruido es necesario volver a simular los registros dando en el botn Simular Registros'},'Ruido Impulsivo')

% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg('En el Panel Matriz de pocas simuladas se puede visualizar, la matriz de pocas limpias simaladas, la matriz de pocas ms ruido y en la tercera figura la densidad espectral de la seal simulada ms el ruido','Matriz de pocas simuladas')

% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'El panel Respuesta Promedio Obtenida est compuesto por:','',...
    'Detrending: Este panel permite eliminar las posibles tendencias presentes en la seal  o nivel DC','Valor Medio: remueve el valor medio de cada poca',...
    'Tendencias lineales: Remueve de forma lineal las tendencias en cada poca',...
    'Modelo Polinomial: Permite remover las tendencias siguiendo un ajuste polinomial segn el orden especficado por el usuario en el espacio Orden',...
    '','Mtodos de Promedio: Permite obtener las respuesta promedio resultante usando diferentes mtodos de promedio',...
    'Promedio Coherente: Mtodo de promedio clsico','Promedio Recortado: Usa mtodo de promedio robusto, donde el por ciento de pocas contenidas en % son eliminadas luego de ordenar la matriz de conjunto que contiene las pocas ms ruido',...
    'Promedio Ponderado: Promedio ponderado o promedio pesado, donde a cada poca se le asigna un peso que es inversamente proporcional a la varianza de ruido en dicha poca',...
    'Promedio WISE: Nuevo mtodo de promedio robusto, donde en lugar de recortar las pocas con valores fuera de rango o pesar las pocas segn su varianza, solo son afectadas las muestras que son comprendidas como outliers, usando adems tcnicas de auemnto de datos, para obtener una matriz de respuestas evocadas con un nmero mayor de respuestas y as garantizar obtner una mejor relacin seal a ruido','',...
    'SNR inicial (dB): Valor de SNR inicial estimado a partir del conocimiento de la onda bsica que dio lugar a las simulaciones de las pocas y de la varianza del ruido simulado','',...
    'SNR final (dB): Valor de SNR final obtenida usando cada uno de los mtodos de promedio y la combinac','','En la figura Comparacin de las respuesats promedios obtenidas se visualizan las respuestas obtenidas usando'...
    'cada mtodo escogido y permite compararlo con la seal original (xo(t))'},'Respuesta Promedio Obtenida')

% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'La pestaa Fichero permite cargar una forma de onda bsica a partir de una seal real, que puede encontrarse en formato .dat, .abr, .mat. Tambin permite cargar una forma de onda conocida, usando diferentes wavelet madres, como:',' db (Daubechies wavelet)', 'sym (Symlets wavelet)',...
    'coif (Coiflets wavelet)','gaus (Gaussian wavelet)','meyr (Meyer wavelet)', 'morl (Morlet wavelet)','todas las ondas wavelet con la posibilidad de escoger rdenes diferentes' },'Fichero')


% --- Executes during object creation, after setting all properties.
function SNRmean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNRmean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function porciento_outliers_Callback(hObject, eventdata, handles)
% hObject    handle to porciento_outliers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of porciento_outliers as text
%        str2double(get(hObject,'String')) returns contents of porciento_outliers as a double
Val=get(hObject,'String');
NewVal=str2double(Val);
if isnan(NewVal)
    NewVal=0;
end
handles.porciento_outliers=NewVal/100;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function porciento_outliers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to porciento_outliers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
