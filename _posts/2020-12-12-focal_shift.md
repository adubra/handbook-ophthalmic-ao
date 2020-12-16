---
layout: post
title:  "Focal shift"
date:   2020-12-12 22:41:57 -0800
author: Vyas Akondi, Alfredo Dubra
permalink: /focal_shift
---
<!--
TODO: how to limit data entry to only numbers, integers or positive floats.

TODO: make sure that href ...# something add offset to account for top banner.

TODO: figure out how to use dataval to retrieve the figure number.

TODO: implement warning when F >= 1 or N>=1 (results, rather than inputs)

TODO: how do we number equations and figures automatically (latex-like??

TODO: get the matlab-icon CSS to work
-->

<h3 id="Focal_shift_definition">Focal shift</h3>

<p>There are two points of interest near the focus of a converging spherical wavefront. The <b>geometrical focus</b>, where the rays orthogonal to the wavefront converge (see figure below), and the point of maximum intensity, which is shifted towards the incoming wavefront due to diffraction, and it is therefore referred to as the <b>diffraction focus</b>. The distance between these two foci, that is, the <b>focal shift</b> (\(\Delta z\)), is a function of the Fresnel number \(N = a^2 / \lambda z\), where \(a\) is the beam radius at a distance \(z\) to the geometrical focus and \(\lambda\) is the light wavelength.
</p>

<figure id="fig_focal_shift_definition">
    <img src="{{ site.baseurl }}/assets/img/Figure - focal shift cartoon.png" alt="Focal shift diagram" class="img-fluid mx-auto" style="max-width:55%;">
    <figcaption class="figure-caption text-center text-justify"><label for="fig_focal_shift_definition"></label> - Focal shift in a spherical wavefront (red lines= propagating from the left to right. The gray rays point towards the geometrical focus (hollow red spot), while the point of maximum intensity, the diffraction focus, is to the left (full red spot).</figcaption>
</figure> 

<p><a href="https://doi.org/10.1364/JOSA.72.000770" target="_blank">Yajun Li</a> (Eq. 3.12) derived an approximate formula for the focal shift of a rotationally symmetric converging wavefront when \(N \geq 0.5\) and \(F \geq 1\), 
</p>
<div>
    \begin{equation}
        \Delta z \simeq - \frac{12 z \left(1 + \frac{1}{8F^2}\right)}{ \pi^2 N^2} \left\{  1 - \exp  \left[
            -\frac{\pi^2 N^2}{12 \left( 1 + \frac{1}{8F^2} \right) \left[ 1 + N \left( 1- \frac{1}{16F^2}\right) \right]}                
            \right]\right\},
        \label{eq:silly_equation_name}
    \end{equation}
</div>
<p>where the f-number of the beam, \(F = z / 2a\). The negative sign indicates that the diffraction focus is always shifted towards the converging wavefront. <a href="https://doi.org/10.1364/JOSAA.20.002156" target="_blank">Colin J. R. Sheppard and Peter Török</a> (Eq. 17) arrived at a simpler formula for high numerical aperture systems with small focal shifts, \(\eqref{eq:silly_equation_name}\)
</p>
<div>
    \begin{align*}
    \Delta z \simeq - \frac{z}{\cos^2(\alpha/2) + \left(\pi^2 N^2/12\right) \sec^2(\alpha/2)},
    \end{align*}
</div>
<p>where \(\alpha = \sin^{-1}(a/z)\).

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



<h3 id="Focal_shift_calculator">Focal shift calculator</h3>
<form id="form_focal_shift_calculator">
<div class="row mt-3">
    <div class="col-lg-6">
            <div class="row mb-3">
                <div class="col-lg-8">
                    <label class="col-form-label">Distance to geometric focus (mm):</label>
                </div>
                <div class="col-lg-4 ">
                    <input name="distance_to_geometric_focus_mm" class="form-control text-right" value = "8">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-lg-8 ">
                    <label class="col-form-label">Beam diameter (mm):</label>
                </div>
                <div class="col-lg-4 ">
                    <input name="beam_diameter_mm" class="form-control text-right" value = "0.2">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-lg-8">
                    <label class="col-form-label">Wavelength (nm):</label>
                </div>
                <div class="col-lg-4">
                    <input name="wavelength_nm" class="form-control text-right" value = "850">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <button type="submit" class="btn btn-primary">Calculate</button>
                </div>
            </div>
    </div>
    <div class="col-lg-6">
        <div class="row mb-3">
            <div class="col-8">
                <label class="col-form-label">Fresnel number:</label>
            </div>
            <div class="col-4">
                <input  readonly  class="form-control text-right" id="Fresnel_number" name="Fresnel_number"/>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-8">
                <label class="col-form-label">f-number:</label>
            </div>
            <div class="col-4">
                <input readonly class="form-control text-right" id="F_number" name="F_number"/>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-8">
                <label class="col-form-label">
                Focal shift <a href="https://doi.org/10.1364/JOSA.72.000770" target="_blank">Li</a>  (mm):</label>
            </div>
            <div class="col-4">
                <input readonly disabled class="form-control text-right" id="Focal_shift_Li" />
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-8">
                <label class="col-form-label">
                Focal shift <a href="https://doi.org/10.1364/JOSAA.20.002156" target="_blank">Sheppard & Török</a> (mm):</label>
            </div>
            <div class="col-4">
                <input readonly disabled class="form-control text-right" id="Focal_shift_Sheppard_n_Torok" />
            </div>
        </div>
    </div>    
</div>
</form>

<br>
<h3 id="Focal_shift_in_SHWS_lenslets">Focal shift in the Shack-Hartmann wavefront sensor</h3>

<p>
When a positive lens free of wavefront aberrations is normally illuminated with a plane wave, the Fresnel number, and thus the focal shift can be calculated n in terms of the lens clear aperture diameter \(D_L\) and its back (geometrical) focal length \(f_L\). In most imaging applications, however, the relative focal shift \(\Delta f_L / f_L\) is negligible. For example, in a typical human eye \( f_{\textrm{eye}}\approx\)16.7 mm imaged with a conventional optical coherence tomgrapher \(D_{\textrm{beam}} \approx\)1.0 mm using 850 nm light, \(\Delta f_{\textrm{eye}} / f_{\textrm{beam}} \approx \)-0.4%. If, on the other hand, we consider a typical Shack-Hartmann wavefront sensor lenslet with 200 um diameter and 8 mm focal length, we have that the relative focal shift is approximately 29-36%, which is not negligible.
</p>
<p>
Now the important question is, <b>why should we care about the focal shift in a Shack-Hartmann wavefront sensor?</b> Because if the pixelated detector is not placed in the geometrical focus, then the centroid of partially illuminated lenslets will be biased in a wavefront-independent manner. This can be solved by ignoring partially illuminated lenslets in the wavefront estimation or reconstruction algorithm, but that could be problematic if the wavefront illuminating the Shack-Hartmann wavefront sensor lenslet array does not have a uniform intensity profile. A more elegant, and arguably simple, solution is to put the pixelated sensor in the geometrical focal plane of the lenslet array, as demonstrated by <a href="https://doi.org/10.1364/OL.44.004151" target="_blank">V. Akondi and A. Dubra</a>. The proposed pixelated sensor focusing approach does not require the calculation of the focal shift, but rather allows finding the geometrical focus by empirically minimizing centroid bias using a test wavefront.
</p>



<script src="https://unpkg.com/mathjs@8.1.0/lib/browser/math.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.min.js" integrity="sha512-SuxO9djzjML6b9w9/I07IWnLnQhgyYVSpHZx0JV97kGBfTIsUYlWflyuW4ypnvhBrslz1yJ3R+S14fdCWmSmSA==" crossorigin="anonymous"></script>
<script src="{{ '/assets/js/calculators.js' | relative_url }}"></script>
<script src="{{ '/assets/js/autonumber.js' | relative_url }}"></script>
<script>
    $(document).ready(function(){
        autonumberByElement('figure', 'Figure');
        renderLabels();
    });
</script>