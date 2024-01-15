classdef reverb < audioPlugin & matlab.System
    %   reverb audioPlugin class generated from reverberator
    %   Command to generate audio plug-in: generateAudioPlugin Garage
    %
    %   See also validateAudioPlugin, generateAudioPlugin.
    
    %   Generated on 14-Jan-2024 15:55:11 UTC-08:00
    
    properties
        PreDelay = 0
        HighCutFrequency = 20000
        Diffusion = 0.5
        DecayFactor = 0.5
        HighFrequencyDamping = 0.0005
        WetDryMix = 0.3
    end
    
    properties (Access = private)
        %privObj
        %   This property holds the reverberator object
        privObj
    end
    
    properties (Constant)
        %PluginInterface
        %   This property defines the audio plugin interface
        PluginInterface = audioPluginInterface( ...
            audioPluginParameter('PreDelay','DisplayName','Pre-delay','Label','s','Mapping',{'lin',0,1}),...
            audioPluginParameter('HighCutFrequency','DisplayName','Highcut frequency','Label','Hz','Mapping',{'log',20,20000}),...
            audioPluginParameter('Diffusion','DisplayName','Diffusion','Label','','Mapping',{'lin',0,1}),...
            audioPluginParameter('DecayFactor','DisplayName','Decay factor','Label','','Mapping',{'lin',0,1}),...
            audioPluginParameter('HighFrequencyDamping','DisplayName','High frequency damping','Label','','Mapping',{'lin',0,1}),...
            audioPluginParameter('WetDryMix','DisplayName','Wet/dry mix','Label','','Mapping',{'lin',0,1}),...
            'InputChannels',2, ...
            'OutputChannels',2, ...
            'PluginName','Garage' ...
            )
    end
    
    methods
        function obj = reverb
            obj.privObj = reverberator;
        end
    end
    
    methods (Access = protected)
        function setupImpl(obj, x)
            obj.privObj.PreDelay =0;
            obj.privObj.Diffusion =0.5;
            obj.privObj.DecayFactor =0.5;
            obj.privObj.HighFrequencyDamping =0.0005;
            obj.privObj.WetDryMix =0.3;
            obj.privObj.HighCutFrequency =20000;
            setup(obj.privObj,x);
        end
        
        function processTunedPropertiesImpl(obj)
            obj.privObj.PreDelay = obj.PreDelay;
            obj.privObj.HighCutFrequency = obj.HighCutFrequency;
            obj.privObj.Diffusion = obj.Diffusion;
            obj.privObj.DecayFactor = obj.DecayFactor;
            obj.privObj.HighFrequencyDamping = obj.HighFrequencyDamping;
            obj.privObj.WetDryMix = obj.WetDryMix;
        end
        
        function y = stepImpl(obj, x)
            y = step(obj.privObj, x);
        end
        
        function resetImpl(obj)
            obj.privObj.SampleRate = getSampleRate(obj);
            reset(obj.privObj);
        end
        
        function releaseImpl(obj)
            release(obj.privObj);
        end
        
        function s = saveObjectImpl(obj)
            s = saveObjectImpl@matlab.System(obj);
            if isLocked(obj)
                s.privObj = matlab.System.saveObject(obj.privObj);
            end
        end
        
        function loadObjectImpl(obj, s, wasLocked)
            if wasLocked
                obj.privObj = matlab.System.loadObject(s.privObj);
            end
            loadObjectImpl@matlab.System(obj,s,wasLocked);
        end
    end
end

% [EOF]
