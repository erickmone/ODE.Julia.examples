using OrdinaryDiffEq
using LinearAlgebra
using LaTeXStrings
using Plots

# Cool colors palette
# https://juliagraphics.github.io/Colors.jl/stable/namedcolors/

E  = 48;
R  = 144;
L  = 2.7648e-3;
C  = 1.666667e-6;
D  = 0.6;
Dₚ = 1-D;
x₀ = [0; 0];

# Equilibria 

VC = E/Dₚ;
IL = E/(R*(Dₚ^2));


function dxdt(dx,x,p,t)
    global L,C,E,R,Dₚ;
    dx[1] = (1/L)*(E - Dₚ*x[2]);
    dx[2] = (1/C)*(Dₚ*x[1] -(1/R)*x[2]);
end 

t = (0,0.01)

prob = ODEProblem(dxdt,x₀,t)

# Simulate using ODE Solver
sol = solve(prob, Tsit5())
 
# And plot


p = plot(sol,
         lw=3,
         tspan=(0,0.003),
         layout=(2,1), 
         xlabel=["" "Time \$t\$ [s]"],
         ylabel=["Current [A]" "Voltage [V]"],
         label = ["\$i_L(t)\$" "\$v_C(t)\$"], 
         title = ["Response of the Boost Converter" ""],
         color = [:red :blue])
