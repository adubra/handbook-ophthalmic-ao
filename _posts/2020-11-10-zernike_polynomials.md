---
layout: post
title:  "Zernike polynomials"
date:   2020-12-12 22:41:57 -0800
author: Vyas Akondi, Alfredo Dubra
permalink: /zernike_polynomials
---
<!--
-->

<h3 id="zernike_definition">Definition in polar coordinate system</h3>

<p>The <a href="https://en.wikipedia.org/wiki/Zernike_polynomials" target="_blank">Zernike polymials</a>  form an orthogonal basis within the unit circle, when defined using polar coordinates (\(\rho,\theta\))  as follows,
</p>
<div>
    \begin{eqnarray} \label{zernike_definition_B&W}
        Z_n^m (\rho,\theta)& = & N_n^m R_n^{|m|}(\rho)
        \begin{cases}
            \cos(|m|\theta), & \text{for $m \geq 0$} \\
            \sin(|m|\theta), & \text{for $m < 0$}
        \end{cases} \\
    \end{eqnarray}
</div>
<p> where \(\theta\) measured from the \(x\) axis, \(\delta_{m,0}\) is the Kroneckers delta function, and
</p>
<div>
    \begin{equation}\label{Zernike_radial_part}
        R_{n}^{|m|}(\rho) = \sum_{s=0}^{(n-|m|)/2}\frac{(-1)^{s}(n-s)!}{s![(n+|m|)/2-s]![(n-|m|)/2-s]!}\rho^{n-2s},
    \end{equation}
</div>
<p>with the integer indices \(n\) and \(m\) that meet the conditions \(n \geq
0\), \(|m| \leq n\), and \(n-|m|\) is even, are allowed. The normalization factor, 
\begin{equation}
    N_n^m = \sqrt{\frac{2(n+1)}{1 + \delta_{m,0}}},
\end{equation} 
which is promoted by the Optical Society of America's document <a href="https://doi.org/10.1364/VSIA.2000.SuC1" target="_blank">Standards for Reporting the Optical Aberrations of Eyes</a> makes the polynomials have unit norm.
</p>

<!-- TODO: Vyas, should we create a figure showing the xy plane with the unit circle and polar coordinates? -->

<h3 id="zernike_definition">Definition in Cartesian coordinate system</h3>

The Zernike polynomials can also be expressed in Cartesian coordinates as follows (See <a href="https://doi.org/10.1016/0030-4018(94)90241-0" target="_blank"> Carpio & Malacara</a> and section 4 in <a href="https://doi.org/10.1364/OE.393223" target="_blank"> Akondi & Dubra</a>)

<div>
\begin{eqnarray} \label{zernike_definition_Carpio_Malacara_1}
    Z_n^{m \geq 0} (x,y) = N_n^m \sum_{k=0}^{n'} \binom{n'}{k} & &\binom{n'+|m|+k}{n'} \sum_{v=0}^k \binom{k}{v} \nonumber \\
                                                               & & \sum_{p=\lceil v/2 \rceil}^{\lfloor (k+|m|+v)/2 \rfloor} (-1)^{n'-k+v+p} \binom{k+|m|}{2p-v} x^{2k+|m|-2p} y^{2p}, \text{and}
\end{eqnarray}
</div>

<div>
\begin{eqnarray} \label{zernike_definition_Carpio_Malacara_2}
    Z_n^{m < 0} (x,y) = N_n^m \sum_{k=0}^{n'} \binom{n'}{k} & &\binom{n'+|m|+k}{n'} \sum_{v=0}^k \binom{k}{v} \nonumber \\
                                                            & & \sum_{p=\lceil (v+1)/2 \rceil}^{\lfloor (k+|m|+v+1)/2 \rfloor} (-1)^{n'-k+v+p-1} \binom{k+|m|}{2p-1-v} x^{2k+|m|-2p+1} y^{2p-1},
\end{eqnarray}
</div>

<p> where \(n'\)=(\(n\)-\(|m|\))/2.
</p>


<h5 class="mt-3">Download code here:</h5>

<ul>
    <li><span class="matlab-color">Matlab <i class="matlab-icon"></i> </span> - <a href="{{ site.baseurl }}/assets/code_matlab/fn_zernike_polar.m">Zernike evaluation function in polar coordinates</a>
    </li>
    <li><span class="matlab-color">Matlab <i class="matlab-icon"></i> </span> - <a href="{{ site.baseurl }}/assets/code_matlab/fn_zernike_cartesian.m">Zernike evaluation function in Cartesian coordinates</a>
    </li>
    <li><span class="python-color">Python <i class="fab fa-python"></i></span> - <a href="{{ site.baseurl }}/assets/code_python/fn_focal_shift_calculator.py">TODO function</a>
    </li>
<br>
</ul>



<h3 id="zernike_indexing">Indexing</h3>

Here we adopt the single index notation promoted by the Optical Society of America's document <a href="https://doi.org/10.1364/VSIA.2000.SuC1" target="_blank">Standards for
Reporting the Optical Aberrations of Eyes</a>.


Reporting the Optical Aberrations of Eyes (SROAE) TODO: insert citation,
etc.  The table below shows how to convert from the two index to
the SROAE one index notation.

<figure id="fig_zernike_index_conversion">
    <img src="{{ site.baseurl }}/assets/img/Figure - Zernike index conversion.png" alt="Focal shift diagram" class="img-fluid mx-auto" style="max-width:55%;">
    <figcaption class="figure-caption text-center text-justify"><label for="zernike_definition"></label> -TODO fix missing figure index Zernike index convertion .</figcaption>
</figure> 



<h5 class="mt-3">Download code here:</h5>

<ul>
    <li><span class="matlab-color">Matlab <i class="matlab-icon"></i> </span> - <a href="{{ site.baseurl }}/assets/code_matlab/fn_zernike_index_conversion.m">Function to convert Single index to Double index Zernike notation and vice versa</a>
    </li>
    <li><span class="python-color">Python <i class="fab fa-python"></i></span> - <a href="{{ site.baseurl }}/assets/code_python/fn_focal_shift_calculator.py">TODO function</a>
    </li>
<br>
</ul>


<h3 id="zernike_wavefront_representation">Wavefront representation</h3>

The Zernike polynomials introduced in equation
\ref{zernike_definition_B&W} form an orthonormal basis in the
function space defined by the unit circle (\(Omega\)), that is,

<div>
    \begin{eqnarray}
    \langle Z_n^m , Z_{n'}^{m'} \rangle_\Omega  &=&
    \frac{1}{\pi}\int^1_0 \int^{2\pi}_0 Z_n^m (\rho,\theta)
    Z_{n'}^{m'}(\rho,\theta) \rho d
    \rho d \theta\\
    & = & \delta_{m,m'} ~ \delta_{n,n'}.
    \end{eqnarray}
</div>

This condition is written in different ways according to which
normalisation factor is used when defining the polynomials.  The
definition given here is the one we believe more practical and is
also the recommended one in the SROAE.  The wavefront $W$ can be
expressed in terms of the Zernike polynomials in the same way we
decompose a vector in a linear space by projecting onto vectors
that form an orthonormal basis (which is actually the case),

<div>
    \begin{eqnarray}
    W = \sum_{n,m} a_{n,m} ~ Z_n^m
    \end{eqnarray}
</div>

where the amplitude coefficients are given by

<div>
    \begin{eqnarray}
    a_{n,m}  = \langle  Z_n^m , W \rangle_\Omega
    \end{eqnarray}
</div>

The norm of the wavefront in the pupil space, is the
root-mean-square (RMS) of the wavefront $\sigma_W$ and takes the
simple form

<div>
    \begin{eqnarray}\nonumber
    \sigma_W = \sqrt{ \sum_{n,m} a_{n,m}^2}
    \end{eqnarray}
</div>


<div>
    \begin{figure}[h]
    \centering
    \includegraphics{zernike_meshes_portrait.eps}
    \caption{3D representation of the first Zernike polynomials using the two index notation.}
    \end{figure}
</div>


<!--
\begin{center}
\begin{tabular}{|c|c|c|c|c|}
  \hline
  $n$ & $m$ & $Z_n^m(\rho,\theta)$ & $Z_n^m(x,y)$ &  \\
  \hline
  0 & 0  & 1 & 1 & piston\\
  1 & -1 & $2 \rho \sin \theta$                &  $2x$                & tip \\
  1 & -1 & $2 \rho \cos \theta$                &  $2y$                & tilt  \\
  2 & -2 & $\sqrt{6} \rho^2 \sin ( 2 \theta )$ &  $2\sqrt{6}xy$               & astigmatism $45^o$\\
  2 &  0 & $\sqrt{3} ( 2 \rho^2 -1 )$          &  $ \sqrt{3} \left[2 (x^2+y^2) - 1\right]$ & defocus \\
  2 &  2 & $\sqrt{6} \rho^2 \cos ( 2 \theta )$ &  $\sqrt{6} \left(y^2 - x^2\right)$        & astigmatism $0^o$ \\
  3 & -3 & $\sqrt{8} \rho^3 \sin ( 3 \theta )$ &  $\sqrt{8} \left(3xy^2-x^3\right)$        & triangular astigmatism $x$-axis  \\
  3 & -1 & $\sqrt{8} (3\rho^3-2\rho)\sin (3\theta)$&  $ \sqrt{8} \left(-2x+3xy^2+3x^3\right)$ & third order coma $x$-axis \\
  3 &  1 & $\sqrt{8} (3\rho^3-2\rho)\cos (3\theta)$&  $ -2y+3yx^2+3y^3$ & third order coma $y$-axis \\
  3 &  3 & $\sqrt{8} \rho^3 \cos ( 3 \theta )$ &  $-3yx^2+y^3$        & triangular astigmatism $y$-axis  \\
  \vdots & \vdots  & \vdots & \vdots & \vdots\\
  4 & 0  & $\sqrt{5}\left(6\rho^4 - 6\rho^2 +1\right)$ & $\sqrt{5}\left[6(x^2+y^2)^2 - 6(x^2+y^2)+1\right]$ & spherical
  aberration\\
  \hline
\end{tabular}
\end{center}
-->
<div>
    <table class="text-center">
        <thead>
            <tr>
                <th>\(n\)</th>
                <th>\(m\)</th>
                <th>\(Z_n^m(\rho,\theta)\)</th>
                <th>\(Z_n^m(x,y)\)</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <tr><td>0</td><td>0</td><td>1</td><td>1</td><td>piston</td></tr>
            <tr><td>1</td><td>-1</td><td>\(2 \rho \sin \theta\)</td><td>\(2x\)</td><td>tip</td></tr>
            <tr><td>1</td><td>-1</td><td>\(2 \rho \sin \theta\)</td><td>\(2y\)</td><td>tilt</td></tr>
            <tr><td>2</td><td>-2</td><td>\(\sqrt{6} \rho^2 \sin ( 2 \theta )\)</td><td>\(2\sqrt{6}xy\)</td><td>astigmatism \(45^o\) </td></tr>
            <tr><td>2</td><td>0</td><td>\(\sqrt{3} ( 2 \rho^2 -1 )\) </td><td>\(\sqrt{3} \left[2 (x^2+y^2) - 1\right]\)</td><td>defocus</td></tr>
            <tr><td>2</td><td>2</td><td>\(\sqrt{6} \rho^2 \cos ( 2 \theta )\)</td><td>\(\sqrt{6} \left(y^2 - x^2\right)\)</td><td>astigmatism \(0^o\)</td></tr>
            <tr><td>3</td><td>-3</td><td>\(\sqrt{8} \rho^3 \sin ( 3 \theta )\)</td><td>\(\sqrt{8} \left(3xy^2-x^3\right)\)</td><td>triangular astigmatism \(x\)-axis</td></tr>
            <tr><td>3</td><td>-1</td><td>\(\sqrt{8} (3\rho^3-2\rho)\sin (3\theta)\)</td><td>\(\sqrt{8} \left(-2x+3xy^2+3x^3\right)\)</td><td>third order coma \(x\)-axis</td></tr>
            <tr><td>3</td><td>1</td><td>\(\sqrt{8} (3\rho^3-2\rho)\cos (3\theta)\)</td><td>\(-2y+3yx^2+3y^3\)</td><td>third order coma \(y\)-axis</td></tr>
            <tr><td>3</td><td>3</td><td>\(\sqrt{8} \rho^3 \cos ( 3 \theta )\)</td><td>\(-3yx^2+y^3\)</td><td>triangular astigmatism \(y\)-axis</td></tr>
            <tr><td>$\vdots$</td><td>$\vdots$</td><td>$\vdots$</td><td>$\vdots$</td><td>$\vdots$</td></tr>
            <tr><td>4</td><td>0</td><td>$\sqrt{5}\left(6\rho^4 - 6\rho^2 +1\right)$</td><td>$\sqrt{5}\left[6(x^2+y^2)^2 - 6(x^2+y^2)+1\right]$</td><td>spherical aberration</td></tr>
        </tbody>
    </table>
</div>


<h3 id="zernike_conversion_to_diopters">Conversion to diopters</h3>

In ophthalmology and optometry the spectacle prescription is made
in terms of sphere, cylinder and cylinder angle for practical
reasons related to the lens manufacture.  These three numbers can
be expressed in terms of the second order Zernike terms,
i.e.defocus and the two astigs.  The power of a lens with
spherical surfaces can be defined as the inverse of its focal
length, and the unit to express it is called diopter ($D =
m^{-1}$) and referred to as \textit{sphere} (not to be confused
with spherical).

If we for example look at the human eye, that has a typical focal
length of $17mm$, the corresponding sphere value is about $60D$.
 The minimum step between ophthalmic lenses is $1/8D$ although in
practice optometrist will only prescribe using a minimum step of
$1/4D$.

The other corrective type of lens used in spectacles is the
cylindrical lens, that is a lens with spherical section in one
direction and flat in the perpendicular one.  Again, its power
will be given in diopters.

The power $\Phi_A$ of a cylinder can be calculated in terms of the
Zernike amplitude coefficients \cite{LIA94} as

<div>
    \begin{equation}
    \Phi_{A}=\pm\frac{16\sqrt{6 \left( a_{2,2}^2+a_{2,-2}^2 \right)}}{D^{2}}
    \end{equation}
</div>

where D is the diameter of the pupil.  The axis of that cylinder
is given by

<div>
    \begin{equation}
    \alpha=90^{\circ} + \frac{1}{2} ~ \tan^{-1}\left(\frac{-a_{2,-2}}{a_{2,2}}\right)\hspace{2cm} \mbox{when } -c_{2}^{-2}/c_{2}^2 < 0
    \end{equation}
</div>

and

<div>
    \begin{equation}
    \alpha=\frac{1}{2}~\tan^{-1}\left(\frac{a_{2,-2}}{a_{2,2}}\right)
    \hspace{3cm} \mbox{when ~~}c_{2}^{-2}/c_{2}^2 \geq 0.
    \end{equation}
</div>

The sphere is calculated as

<div>
    \begin{equation}\label{sphere}
    \Phi_{S}=-\frac{16 ~ \sqrt{3} ~
    a_{2,0}}{D^{2}}-\frac{1}{2}\Phi_{A}.
    \end{equation}
</div>


where the introduction of half the amplitude of the cylinder can
be thought of in terms of making the value $\Phi_D$ the focal
length of the spherical lens that would correct best both defocus
and astigmatism simultaneously.\\


<h5 class="mt-3">Download code here:</h5>

<ul>
    <li><span class="matlab-color">Matlab <i class="matlab-icon"></i> </span> - <a href="{{ site.baseurl }}/assets/code_matlab/fn_focal_shift_calculator.m">focal shift calculator function</a>
    </li>
    <li><span class="matlab-color">Matlab <i class="matlab-icon"></i></span> - <a href="{{ site.baseurl }}/assets/code_matlab/test_fn_focal_shift_calculator_01.m">script demonstrating its use</a>
    </li>
    <li><span class="python-color">Python <i class="fab fa-python"></i></span> - <a href="{{ site.baseurl }}/assets/code_python/fn_focal_shift_calculator.py">focal shift calculator function</a>
    </li>
    <li><span class="python-color">Python <i class="fab fa-python"></i></span> - <a href="{{ site.baseurl }}/assets/code_python/test_fn_focal_shift_calculator_01.py">script demonstrating its use</a>
    </li>
<br>
</ul>


<br>


<p>

</p>
<p>

</p>


<script src="https://unpkg.com/mathjs@8.1.0/lib/browser/math.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.min.js" integrity="sha512-SuxO9djzjML6b9w9/I07IWnLnQhgyYVSpHZx0JV97kGBfTIsUYlWflyuW4ypnvhBrslz1yJ3R+S14fdCWmSmSA==" crossorigin="anonymous"></script>
<script src="{{ '/assets/js/calculators.js' | relative_url }}"></script>
