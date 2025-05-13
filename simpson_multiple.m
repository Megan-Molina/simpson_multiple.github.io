% Definir parámetros
a = 0;
b = 0.8;
n = 6; % debe ser par
h = (b - a) / n;

% Definir la función original
f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;

% Crear los puntos x y evaluar f(x)
x = a:h:b;
fx = f(x);

% Simpson 1/3 múltiple
I_simpson = (h/3) * (fx(1) + 4*sum(fx(2:2:end-1)) + 2*sum(fx(3:2:end-2)) + fx(end));

% Cuarta derivada
syms xs;
f_sym = 0.2 + 25*xs - 200*xs^2 + 675*xs^3 - 900*xs^4 + 400*xs^5;
f4_sym = diff(f_sym, xs, 4);
f4 = matlabFunction(f4_sym);

% Valor medio de la cuarta derivada
media_f4 = integral(f4, a, b) / (b - a);

% Estimar error de truncamiento
% Error <= -((b-a)^5 / (180 * n^4)) * f^(4)(ξ)
error_trunc = -((b - a)^5 / (180 * n^4)) * media_f4;

% Valor exacto dado
valor_exacto = 1.640533;

% Error relativo porcentual
error_relativo = abs((valor_exacto - I_simpson) / valor_exacto) * 100;

% Mostrar resultados
fprintf('Integral aproximada (Simpson 1/3): %.6f\n', I_simpson);
fprintf('Valor medio de la cuarta derivada: %.6f\n', media_f4);
fprintf('Error de truncamiento estimado: %.6f\n', error_trunc);
fprintf('Error relativo porcentual: %.6f %%\n', error_relativo);
