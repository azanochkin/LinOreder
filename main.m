function varargout = main(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @main_OpeningFcn, ...
                       'gui_OutputFcn',  @main_OutputFcn, ...
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

function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main (see VARARGIN)

    % Choose default command line output for main
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

function varargout = main_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


function input_file_button_Callback(hObject, eventdata, handles)
    [FileName,PathName] = uigetfile({'*.mat'}, 'Select file to open');
    set(handles.input_file_name, 'String', FileName);
    handles.input_filename = strcat(PathName, FileName);
    guidata(gcbo, handles);

function input_file_name_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function init_button_Callback(hObject, eventdata, handles)
    handles.initDate = '2008/07/01';
    handles.suffix = 'NscQrt';
    handles.sector = 'Bank';
    handles.resFile = 'Results\';
    handles.isRgh = false;
    handles.isNorm = true;
    handles.isEqConsid = true;
    guidata(gcbo, handles);
    
    [timeVec, nscRankMat, iscRankMat, agName] = ...
        getNewData_qrt(handles.initDate, handles.sector, ...
            handles.isRgh, handles.isNorm, handles.input_filename);
    
    % нулевые измерения
    iscRankMat = nan(size(nscRankMat));
    maskExRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=1;
    fprintf('-- > observations with 1 or greater ranks: %i\n',sum(maskExRatesVec));
    nscRankMat = nscRankMat(maskExRatesVec,:);
    iscRankMat = iscRankMat(maskExRatesVec,:);
    timeVec = timeVec(maskExRatesVec);
    
    handles.nscRankMat = nscRankMat;
    handles.iscRankMat = iscRankMat;
    handles.agName = agName;
    handles.timeVec = timeVec;
    guidata(gcbo, handles);
    
    set(handles.aglist, 'String', agName);
    set(handles.genetic_panel, 'Visible', 'On');
    
function nIter_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nIter_slider_Callback(hObject, eventdata, handles)
    value = get(hObject, 'Value');
    set(handles.nIter, 'String', num2str(round(value)));

function nIter_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function start_abort_Callback(hObject, eventdata, handles)
    global isAborted
    isAborted = false;
    set(handles.abort_button, 'Enable', 'On');
    set(hObject, 'Enable', 'Off');
    drawnow update;
    
    try
        filename = 'loglog2005.txt'; %[resFile,'stats',initDate(1:4),suffix,sector,datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
        fileID = fopen(filename,'w+');
        if fileID == -1
            error('classification:fopen','cannot open file')
        end
%             open(filename)
        %
        OptimFnc = @(lMat)genetic(lMat,100,100,30,10,0.1,fileID);
        consRankMat = taskShareSC(...
                handles.timeVec, ...
                handles.nscRankMat, ...
                handles.iscRankMat, ...
                handles.isEqConsid, ...
                OptimFnc);

        fclose(fileID);
    catch err
        if ~(strcmp(err.identifier,'classification:fopen'))
            fclose(fileID);
        end
        rethrow(err);
    end
    
    handles.consRankVec = srenumber(consRankMat(:,1));
    guidata(gcbo, handles);
    
    set(handles.start_abort, 'Enable', 'On');
    set(handles.rifling_panel, 'Visible', 'On');

function abort_button_Callback(hObject, eventdata, handles)
    global isAborted
    isAborted = true;
    set(hObject, 'Enable', 'Off');
    drawnow update;

function aglist_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rifling_button_Callback(hObject, eventdata, handles)
    consRankVec = handles.consRankVec;
    % relMatrixArr = relationMatrix(timeVec, nscRankMat, iscRankMat, isEqConsid);
    % indProxy = findProxy( relMatrixArr,agName);
    indProxy = 2;
    handles.indProxy = indProxy;
    proxRankVec = handles.nscRankMat(:,indProxy);
    isNanProxVec = ~isnan(proxRankVec);
    isMinRatVec = sum(~(isnan(handles.nscRankMat)&isnan(handles.iscRankMat)),2)>=2;
    isObsVec = isNanProxVec;
    %isObsVec = isNanProxVec & isMinRatVec;
    kemRankVec = classifyu(consRankVec,consRankVec(isObsVec),proxRankVec(isObsVec),true);
    
    handles.kemRankVec = kemRankVec;
    guidata(gcbo, handles);
    
    %kemRankVec = roundRifling(proxRankVec , consRankVec );
    %consRankVec = rifling( nscRankMat(:,indProxy), consRankVec );
    plot(consRankVec,kemRankVec,'+')
    plot(consRankVec(isObsVec),proxRankVec(isObsVec),'^g')

    set(handles.save_panel, 'Visible', 'On');
    
function save_button_Callback(hObject, eventdata, handles)
    agName = handles.agName;
    nscRankMat = handles.nscRankMat;
    kemRankVec = handles.kemRankVec;
    
    quantiles = [0.5 0.4 0.3 0.2 0.1];
    [medianKemMat, quantArr ,medianNumCell] = getStats(nscRankMat, kemRankVec, quantiles );
    load('agGradeName.mat')
    filename = [handles.resFile,'result',handles.sector,...
        handles.suffix,handles.initDate(1:4),agName{indProxy},'.xls'];
    [medianKemCell,quantCell,medianCell] = ...
        convertStat(medianKemMat,quantArr,medianNumCell,agGradeName);
    dict = agGradeName{indProxy};
    % for j=1:10
    %             dict{j} = num2str(j);
    %         end
    proxyGrades = dict(1+unique(kemRankVec));
    %
    qNames = cell(size(quantiles));
    for k = 1:length(quantiles)
        qNames{k} = ['Quan_',num2str(100*quantiles(k)),'pr'];
    end
    %
    for i = 1:length(agGradeName)
        tbl = cell2table(quantCell(:,:,i));
        tbl = [medianKemCell(:,i) tbl];
        tbl = [medianCell(:,i) tbl];   
        tbl.Properties.VariableNames = ['Median_ag' 'Median_Cons' qNames];
        %
        tbl.Properties.RowNames = proxyGrades;
        writetable(tbl,filename,'Sheet',agName{i},'WriteRowNames',true);
    end
    tbl = cell2table(medianCell);
    tbl.Properties.RowNames = proxyGrades;
    tbl.Properties.VariableNames = agName;
    writetable(tbl,filename,'Sheet','Median_ag','WriteRowNames',true);
