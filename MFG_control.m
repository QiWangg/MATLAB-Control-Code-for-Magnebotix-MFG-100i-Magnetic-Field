
% 1: Runs a frequency sweep from 0 to 10Hz at 10mT (can be changed inside code)
% 2: Runs a field strength sweep 5, 10, 15, 17Hz  
% value in valueMFG tells the direction either 1 or -1
% The third value is sets the frequency for Field intensity experiment
valueMFG = [1 1 3]; 
T1 = 0; % Hz = 1/2mT
F2 = 10; % Field strength for experiments mT
T3 = 5;  % How long do you run each frequency?
  
if valueMFG(1) == 1
    
    pause()

    %%% Frequency manipulation with constant field strength %%%
    minimag.fieldmagnitude = F2; % mT
    minimag.rotationrate   = 0; % Hz
    minimag.yaw  = deg2rad(valueMFG(2)*0); % r
    minimag.pitch = deg2rad(valueMFG(2)*0); % rad
    minimag.roll = deg2rad(valueMFG(2)*90); % rad
    
    %%% Frequency manipulation with constant field strength %%%
    
    freqRBC = [1 2 3 4 5 6 7 8 9 10]; 
  

    lengthFreq = length(freqRBC);
    T = zeros(lengthFreq,1);

    for iter01 = 1:lengthFreq
        minimag.rotationrate = freqRBC(iter01);
        disp(freqRBC(iter01));
        
        minimag = enableECB(minimag); 
        tic
        T(iter01) = toc;
        while T(iter01) < T3
            minimag = rotate(minimag);
            T(iter01) = toc;
        end
    end
elseif valueMFG (1)==2
    fixedFreq = valueMFG(3);             % Frequency fixed at 3 Hz
    fieldStrengths = [5 10 15 17]; % Field strengths in mT
    runTime = 10;              % Duration to run each field strength (seconds)

    % Initial setup for minimag object
    minimag.rotationrate = fixedFreq;  % fix frequency
    minimag.yaw  = deg2rad(0);          
    minimag.pitch = deg2rad(0);         
    minimag.roll = deg2rad(90);         

   % Loop through each field strength
   for i = 1:length(fieldStrengths)
       minimag.fieldmagnitude = fieldStrengths(i);
       disp(['Running field magnitude: ', num2str(fieldStrengths(i)), ' mT at ', num2str(fixedFreq), ' Hz']);
    
       minimag = enableECB(minimag);  
    
       tic
       elapsed = 0;
       while elapsed < runTime
           minimag = rotate(minimag);
           elapsed = toc;
       end
   end
end
 
%  end the ECB

minimag = disableECB(minimag);