classdef physicalConstantsSI
    %physical constants in S.I.
    properties(Constant = true)
        %units of S.I.
        m = sym('m') %meter
        s =sym('s') %second
        kg = sym('kg') %kilogram
        C = sym('C') %Coulomb
        K = sym('K')%Kelvin
        J=str2sym('kg*m^2/s^2') %Joule
        N=str2sym('kg*m/s^2') %Newton
        g=str2sym('kg/1000') %gram
        cm=str2sym('m/100') %centimeter
        
        %units of energy
        eV=str2sym('1.602176634*10^-19*kg*m^2/s^2')
        MeV=str2sym('10^6*1.602176634*10^-19*kg*m^2/s^2')
        GeV=str2sym('10^9*1.602176634*10^-19*kg*m^2/s^2')
        TeV=str2sym('10^12*1.602176634*10^-19*kg*m^2/s^2')
        PeV=str2sym('10^15*1.602176634*10^-19*kg*m^2/s^2')
        EeV=str2sym('10^18*1.602176634*10^-19*kg*m^2/s^2')
        
        %units of high energy area
        b=str2sym('10^-28*m^2') %barn
        Mb=str2sym('10^-22*m^2') %Megabarn
        kb=str2sym('10^-25*m^2') %kilobarn
        mb=str2sym('10^-31*m^2') %millibarn
        mub=str2sym('10^-34*m^2') %micronbarn
        nb=str2sym('10^-37*m^2') %nanobarn
        pb=str2sym('10^-40*m^2') %picobarn
        fb=str2sym('10^-43*m^2') %fetobarn
        ab=str2sym('10^-46*m^2') %attobarn
        zb=str2sym('10^-49*m^2') %zeptobarn
        yb=str2sym('10^-52*m^2') %yoctobarn
        
        %constants
        c=str2sym('299792458*m/s') % speed of light
        h=str2sym('6.62607015*10^-34*kg*m^2/s') %Planck constant
        hbar=str2sym('1.054571817*10^-34*kg*m^2/s') %Planck constant reduced
        e=str2sym('1.602176634*10^-19*C') %charge of electron
        m_e= str2sym('9.1093837015*10^-31*kg') %mass of electron
        m_p= str2sym('1.67262192369*10^-27*kg') %mass of proton
        m_n=str2sym('1.00866491595* 1.66053906660*10^-27*kg') %mass of neutron
        alpha_e= 1/137.035999084 %fine-structure constant of electromagneism
        G_g=str2sym('6.67430*10^-11*m^3*kg^-1*s^-2') %gravational constant
        N_A=6.02214076*10^-23 %Avagadro constant
        k_B=str2sym('1.380649*10^-23*kg*m^2/s^2/K') %Boltzman constant
        alpha_s=0.1179 %strong coupling constant
        
    end
    methods
        %Get the dimension of a func
        function d=dimensionSI(obj,func)
           E=exp(1);
           d.m = log( eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[E,1,1,1,1] ) ) ...
               / eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,1] ) ) );
           d.s = log( eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,E,1,1,1] ) ) ...
               / eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,1] ) ) );
           d.kg = log( eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,E,1,1] ) ) ...
               / eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,1] ) ) );
           d.C = log( eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,E,1] ) ) ...
               / eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,1] ) ) );
           d.K = log( eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,E] ) ) ...
               / eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,1] ) ) );
        end
        %Get the value in S.I.
        function [value,d]=valueSI(obj,func)
            value=eval( subs( func,[obj.m,obj.s,obj.kg,obj.C,obj.K],[1,1,1,1,1] ) );
            d=obj.dimensionSI(func);
        end
        %Get the value in natural units
        function [value,D]=valueNatural(obj,func)
            %Get the units 
            d= obj.dimensionSI(func);
            % dimension of eV
            de=(d.kg-d.s-d.m); 
            if de == 0
                D = sym(0)
            else D = obj.eV^de;
            end
            division = (obj.eV/obj.c^2)^d.kg * (obj.eV/obj.hbar)^(-1*(d.m+d.s)) * obj.c^d.m;
            func1=func/division;
            value = obj.valueSI(func1);
        end
        %transform from Natural units to S.I. for 1.energy 2.momentum 3.
        %mass 4.time 5.length 6.area
        function Result = Natural2SI(obj,func,unit)
            value=obj.valueNatural(func);
            result = 0;
            if unit == "energy"
                result = value*obj.eV;
            elseif unit == "momentum"
                result = value*obj.eV/obj.c;
            elseif unit == "mass"
                result = value*obj.eV/obj.c^2;
            elseif unit == "time"
                result = value*obj.hbar/obj.eV;
            elseif unit == "length"
                result = value*obj.hbar*obj.c/obj.eV;
            elseif unit == "area"
                result = value*(obj.hbar*obj.c/obj.eV)^2;
            else
                fprintf("invalid unit");
            end
            Result = obj.valueSI(result);
        end
    end
end












