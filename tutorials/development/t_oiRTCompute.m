%% Setting up and running the ray trace calculation
%
% The ray-trace optics model is one of several types used in
% ISET.  The key feature of the ray trace is that it includes
% field-height and wavelength dependent point spread functions.
% These can either be specified synthetically, or they can be
% derived from optics software, such as Zemax.
%
% See also:  s_opticsRTGridLines, t_oiCompute
%
% Copyright ImagEval Consultants, LLC, 2011.

%%
ieInit

%% Make an example scene radiance of points

scene = sceneCreate('point array',384,32);   % Creates an array of points
scene = sceneSet(scene,'fov',5);  

% To speed the computatons we use a small number of wavelength samples
scene = sceneInterpolateW(scene,(550:100:650));

% Add the scene to the ISET database and view it
ieAddObject(scene); sceneWindow;

%% Create an optical image (oi) that uses the default ray trace model

% This model has a default lens we converted from Zemax to the array of
% point spread functions
oi = oiCreate('ray trace');

% If you would like to see the point spread functions, you can use this
% code.
%
%   wave = 550;
%   fhmm = 0.5;
%   rtPlot(oi,'psf',wave,fhmm);
%   psfMovie(oiGet(oi,'optics'));
%   ieAddObject(oi); oiWindow;

% Confrim that the optics model type is set to ray trace
% In general, optics parameters can be read out with this syntax using an
% oiGet() call.

fprintf('Optics model:       %s\n',oiGet(oi,'optics model'))
fprintf('Ray trace lens:     %s\n',oiGet(oi,'optics rt name'))  % Name of the lens used by ray trace

%% The oiCompute will call opticsRayTrace to do the computation

oi = oiCompute(scene,oi);

% Here is the blurred result
ieAddObject(oi); oiWindow;

%%
