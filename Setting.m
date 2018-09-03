function varargout = Setting(varargin)
% SETTING MATLAB code for Setting.fig
%      SETTING, by itself, creates a new SETTING or raises the existing
%      singleton*.
%
%      H = SETTING returns the handle to a new SETTING or the handle to
%      the existing singleton*.
%
%      SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTING.M with the given input arguments.
%
%      SETTING('Property','Value',...) creates a new SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Setting

% Last Modified by GUIDE v2.5 24-Jul-2018 15:32:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Setting_OpeningFcn, ...
                   'gui_OutputFcn',  @Setting_OutputFcn, ...
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


% --- Executes just before Setting is made visible.
function Setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Setting (see VARARGIN)

global GD

% Choose default command line output for Setting
handles.output = hObject;

% Setting file?
if exist('GD_Save_v2.mat', 'file')>0
    load('GD_Save_v2.mat');
else
    % Input file
    cDir = [pwd '/'];
    GD.InputFile = [cDir ''];
    % ROI file
    GD.RoiFile = [cDir ''];
    % OutputFile
    GD.OutputFolder = cDir;
    % Data type
    GD.DataType = 1;
    % Load ROI Name From File
    GD.fRoi = false;
    % Save Basin List
    GD.fSaveBasinList = false; 
    % Threshold
    GD.Threshold = 0.0;
    % Added from ver.2
    % Processing Type
    GD.ProcessingType = 1;
    % Basin Data Generation
    GD.fReadBasinData = false;
    % Basin Data File
    GD.BasinDataFile = [cDir ''];
    
end

% GUI setting
% Input file
h = findobj('Tag', 'edit_input_file');
set(h, 'String', GD.InputFile);

% Output folder
h = findobj('Tag', 'edit_output_folder');
set(h, 'String', GD.OutputFolder);

% ROI file
h = findobj('Tag', 'edit_roi');
set(h, 'String', GD.RoiFile);

% Data type
h = findobj('Tag', 'uibuttongroup_data_type');
h2 = findobj('Tag', 'edit_th');
switch h.SelectedObject.String
    case 'Continuous data'
        set(h2, 'Enable', 'on');
    case 'Binarized data'
        set(h2, 'Enable', 'off');
end

% Threshold
h = findobj('Tag', 'edit_th');
set(h, 'String', num2str(GD.Threshold));

% Load ROI Name From File
h = findobj('Tag', 'checkbox_roi');
set(h, 'Value', GD.fRoi);
if get(h, 'Value') >0
    h2 = findobj('Tag', 'edit_roi');
    set(h2, 'Enable', 'on');
    h3 = findobj('Tag', 'pushbutton_roi');
    set(h3, 'Enable', 'on');
    %GD.fRoi = true;
else
    h2 = findobj('Tag', 'edit_roi');
    set(h2, 'Enable', 'off');
    h3 = findobj('Tag', 'pushbutton_roi');
    set(h3, 'Enable', 'off');
    %GD.fRoi = false;
end

% Save Basin List
h = findobj('Tag', 'checkbox_basin_list');
if GD.fSaveBasinList
    set(h, 'Value', 1);
else
    set(h, 'Value', 0);
end

% Added from ver.2
% Processing Type
h = findobj('Tag', 'uibuttongroup_processing_type');
h2 = findobj('Tag', 'uipanel_basin_data');
h3 = findobj('Tag', 'uibuttongroup_basin_data_generation');

switch h.SelectedObject.Tag
    case 'radiobutton_elc'
        set(h2, 'Visible', 'off');
        set(h3, 'Visible', 'off');
    case 'radiobutton_ia'
        set(h2, 'Visible', 'on');
        set(h3, 'Visible', 'on');
end

% Basin Data file
h = findobj('Tag', 'edit_basin_data_file');
set(h, 'String', GD.BasinDataFile);

h = findobj('Tag', 'uibuttongroup_basin_data_generation');
switch h.SelectedObject.Tag
    case 'radiobutton_cel'
        h0 = findobj('Tag', 'text_basin_data_file');
        set(h0, 'Enable', 'off');
        h2 = findobj('Tag', 'edit_basin_data_file');
        set(h2, 'Enable', 'off');
        h3 = findobj('Tag', 'pushbutton_basin_data_file');
        set(h3, 'Visible', 'off');
    case 'radiobutton_read_basin_data'
        h0 = findobj('Tag', 'text_basin_data_file');
        set(h0, 'Enable', 'on');
        h2 = findobj('Tag', 'edit_basin_data_file');
        set(h2, 'Enable', 'on');
        h3 = findobj('Tag', 'pushbutton_basin_data_file');
        set(h3, 'Visible', 'on');
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_quit.
function pushbutton_quit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GD

% Save
save GD_Save_v2.mat GD

% Quit
close(Setting);

% --- Executes on button press in pushbutton_go.
function pushbutton_go_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GD

% GUI setting
% Input file
h = findobj('Tag', 'edit_input_file');
GD.InputFile = get(h, 'String');

% Output folder
h = findobj('Tag', 'edit_output_folder');
GD.OutputFolder = get(h, 'String');

% ROI file
h = findobj('Tag', 'edit_roi');
GD.RoiFile = get(h, 'String');

% Data type
h = findobj('Tag', 'uibuttongroup_data_type');
switch h.SelectedObject.String
    case 'Continuous data'
        GD.DataType = 1;
    case 'Binarized data'
        GD.DataType = 2;
end

% Threshold
h = findobj('Tag', 'edit_th');
GD.Threshold = str2double(get(h, 'String'));

% Load ROI Name From File
h = findobj('Tag', 'checkbox_roi');
GD.fRoi = get(h, 'Value');

% Save Basin List
h = findobj('Tag', 'checkbox_basin_list');
if get(h, 'Value') == 1
    GD.fSaveBasinList = true;
else
    GD.fSaveBasinList = false;
end

% Added from ver. 2
% Processing type
h = findobj('Tag', 'uibuttongroup_processing_type');
switch h.SelectedObject.Tag
    case 'radiobutton_elc'
        GD.ProcessingType = 1;
    case 'radiobutton_ia'
        GD.ProcessingType = 2;
end

% Basin Data Generation
h = findobj('Tag', 'uibuttongroup_basin_data_generation');
switch h.SelectedObject.Tag
    case 'radiobutton_cel'
        GD.fReadBasinData = false;
    case 'radiobutton_read_basin_data'
        GD.fReadBasinData = true;
end

% Basin Data file
h = findobj('Tag', 'edit_basin_data_file');
GD.BasinDataFile = get(h, 'String');

save GD_Save_v2 GD

main(GD)



function edit_input_file_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_file as text
%        str2double(get(hObject,'String')) returns contents of edit_input_file as a double


% --- Executes during object creation, after setting all properties.
function edit_input_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_roi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_roi as text
%        str2double(get(hObject,'String')) returns contents of edit_roi as a double


% --- Executes during object creation, after setting all properties.
function edit_roi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_input_file.
function pushbutton_input_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_input_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GD

% Set file
[FileName, PathName, FilterIndex] = uigetfile({'*.*', 'All Files (*.*)'}, ...
    'Select Input File', 'MultiSelect', 'on');
if iscell(FileName) || ischar(FileName)
    if iscell(FileName)
        tmp = [];
        for i=1:length(FileName)
            tmp{i} = [PathName, FileName{i}];
        end
        GD.InputFile = tmp;
    else
        GD.InputFile = [PathName FileName];
    end
end

% Update text
h = findobj('Tag', 'edit_input_file');
set(h, 'String', GD.InputFile);


% --- Executes on button press in pushbutton_roi.
function pushbutton_roi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GD

% Set file
[FileName, PathName, FilterIndex] = uigetfile({'*.*', 'All Files (*.*)'}, ...
    'Select ROI Name File');
if FileName
    GD.RoiFile = [PathName FileName];
end

% Update text
h = findobj('Tag', 'edit_roi');
set(h, 'String', GD.RoiFile);


% --- Executes on button press in checkbox_basin_list.
function checkbox_basin_list_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_basin_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_basin_list


% --- Executes on button press in checkbox_roi.
function checkbox_roi_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_roi

global GD

h = findobj('Tag', 'checkbox_roi');

if get(h, 'Value') >0
    h2 = findobj('Tag', 'edit_roi');
    set(h2, 'Enable', 'on');
    h3 = findobj('Tag', 'pushbutton_roi');
    set(h3, 'Enable', 'on');
    GD.fRoi = true;
else
    h2 = findobj('Tag', 'edit_roi');
    set(h2, 'Enable', 'off');
    h3 = findobj('Tag', 'pushbutton_roi');
    set(h3, 'Enable', 'off');
    GD.fRoi = false;
end

% --- Executes on button press in radiobutton_binarized_data.
function radiobutton_binarized_data_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_binarized_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_binarized_data

h2 = findobj('Tag', 'edit_th');
set(h2, 'Enable', 'off');

% --- Executes on button press in radiobutton_continuous_data.
function radiobutton_continuous_data_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_continuous_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_continuous_data

h2 = findobj('Tag', 'edit_th');
set(h2, 'Enable', 'on');


% --- Executes on button press in pushbutton_output_folder.
function pushbutton_output_folder_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_output_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GD

% Set output folder
tmp = uigetdir(GD.OutputFolder, 'Set Output Folder');
if tmp
    GD.OutputFolder = [tmp '/'];
else 
    return;
end

% Update text
h = findobj('Tag', 'edit_output_folder');
set(h, 'String', GD.OutputFolder);

% --- Executes during object creation, after setting all properties.
function edit_output_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_th_Callback(hObject, eventdata, handles)
% hObject    handle to edit_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_th as text
%        str2double(get(hObject,'String')) returns contents of edit_th as a double


% --- Executes during object creation, after setting all properties.
function edit_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_basin_data_file_Callback(hObject, eventdata, handles)
% hObject    handle to edit_basin_data_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_basin_data_file as text
%        str2double(get(hObject,'String')) returns contents of edit_basin_data_file as a double


% --- Executes during object creation, after setting all properties.
function edit_basin_data_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_basin_data_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_basin_data_file.
function pushbutton_basin_data_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_basin_data_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global GD

% Set file
[FileName, PathName, FilterIndex] = uigetfile({'*.mat', 'mat files (*.mat)'}, 'Select Basin Data File');
if FileName
    GD.BasinDataFile = [PathName FileName];
end

% Update text
h = findobj('Tag', 'edit_basin_data_file');
set(h, 'String', GD.BasinDataFile);


% --- Executes on button press in radiobutton_elc.
function radiobutton_elc_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_elc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_elc

h2 = findobj('Tag', 'uipanel_basin_data');
set(h2, 'Visible', 'off');
h3 = findobj('Tag', 'uibuttongroup_basin_data_generation');
set(h3, 'Visible', 'off');

% --- Executes on button press in radiobutton_ia.
function radiobutton_ia_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_ia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_ia

h2 = findobj('Tag', 'uipanel_basin_data');
set(h2, 'Visible', 'on');
h3 = findobj('Tag', 'uibuttongroup_basin_data_generation');
set(h3, 'Visible', 'on');


% --- Executes on button press in radiobutton_cel.
function radiobutton_cel_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_cel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_cel
h = findobj('Tag', 'text_basin_data_file');
set(h, 'Enable', 'off');
h2 = findobj('Tag', 'edit_basin_data_file');
set(h2, 'Enable', 'off');
h3 = findobj('Tag', 'pushbutton_basin_data_file');
set(h3, 'Visible', 'off');


% --- Executes on button press in radiobutton_read_basin_data.
function radiobutton_read_basin_data_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_read_basin_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_read_basin_data
h = findobj('Tag', 'text_basin_data_file');
set(h, 'Enable', 'on');
h2 = findobj('Tag', 'edit_basin_data_file');
set(h2, 'Enable', 'on');
h3 = findobj('Tag', 'pushbutton_basin_data_file');
set(h3, 'Visible', 'on');
