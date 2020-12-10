---
layout: post
title:  "Online calculators"
date:   2020-11-02 22:41:57 -0800
category: Part 1
author:
permalink: /online-calculators
---
<!--
HINT TO SELF: <a href="#Focal_shift_calculator2">other calculator</a>
-->

<div>
<h3 id="Focal_shift_calculator">Focal shift calculator</h3>

There are two points of interest in a converging spherical wavefront. The <b>geometrical focus</b>, where the rays orthogonal to the wavefront converge (see figure below), and the point of maximum intensity , which is shifted towards the incoming waefront due to diffraction, and it is therefore referred to as the <b>diffraction focus</b>. The distance betwee these two foci, known as the focal shift \(\Delta f\), increases with decreasing beam Fresnel number \(N = a^2 / \lambda f\) where \(a\) is the beam radius, \(z\) is the distance to the beam focus and \(\lambda\) is the light wavelength.

<figure>
    <img src="{{ site.baseurl }}/assets/img/Figure - focal shift cartoon.png" alt="Focal shift diagram" class="img-fluid mx-auto p-3" width="50%">
    <figcaption class="figure-caption text-center">Figure - Focal shift in a spherical wavefront (red lines= propagating from the left to right. The gray rays point towards the geometrical focus (dark red spot), while the point of maximum intensity, the diffraction focus,  is to the left (bright red spot).</figcaption>
</figure> 

<p>When \(N > 1\), <a href="https://doi.org/10.1364/JOSA.72.000770" target="_blank">Yajun Li</a> calculated that the focal shift can be approximated as
</p>
<div>
    \begin{align*}
    \Delta f \simeq - \frac{12 f \left(1 + \frac{1}{8F^2}\right)}{ \pi^2 N^2} \left\{  1 - \exp  \left[
        -\frac{\pi^2 N^2}{12 \left( 1 + \frac{1}{8F^2} \right) \left[ 1 + N \left( 1- \frac{1}{16F^2}\right) \right]}                
            \right]\right\},
    \end{align*}
    where \(F = z / 2a\).
</div>

<p>Similarlly, when \(N > 1\), <a href="https://doi.org/10.1364/JOSA.72.000770" target="_blank">Yajun Li</a> and <a href="https://doi.org/10.1364/JOSAA.20.002156">Colin J. R. Sheppard and Peter Török</a> arrive to a different formula (VYAS TODO what are the hypothesis, or valid ranges??)
</p>
<div>
    \begin{align*}
    \Delta f \simeq - f \left[(\cos(\alpha/2))^2 + (\pi^2 N^2/12) (\sec(\alpha/2))^2\right],
    \end{align*}
</div>
where \(\alpha = \sin^{-1}(a /f)\).



<div class="row mt-3">
    <div class="col-lg-6">
        <form id="frmSampleCalculation1">
            <div class="row mb-3">
                <div class="col-lg-9">
                    <label class="col-form-label">Lenslet geometrical focal length (mm):</label>
                </div>
                <div class="col-lg-3 ">
                    <input name="lenslet_geometric_focal_length_mm" class="form-control">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-lg-9 ">
                    <label class="col-form-label">Lenslet diameter (mm):</label>
                </div>
                <div class="col-lg-3 ">
                    <input name="lenslet_diameter_mm" class="form-control">
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-lg-9">
                    <label class="col-form-label">Wavelength (nm):</label>
                </div>
                <div class="col-lg-3">
                    <input name="wavelength_nm" class="form-control">
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">Calculate</button>
                </div>
            </div>
        </form>
    </div>
    <div class="col-lg-6">
        <div class="row mb-3">
            <div class="col-9">
                <label class="col-form-label">Fresnel number (\(N\)):</label>
            </div>
            <div class="col-3">
                <input readonly disabled class="form-control" id="calcultionResult" />
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-9">
                <label class="col-form-label">F-number (\(F\)):</label>
            </div>
            <div class="col-3">
                <input readonly disabled class="form-control" id="calcultionResult" />
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-9">
                <label class="col-form-label">Focal shift \(\Delta f\), Li, mm):</label>
            </div>
            <div class="col-3">
                <input readonly disabled class="form-control" id="calcultionResult" />
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-9">
                <label class="col-form-label">Focal shift \(\Delta f\), Sheppard & Török, mm):</label>
            </div>
            <div class="col-3">
                <input readonly disabled class="form-control" id="calcultionResult" />
            </div>
        </div>
    </div>
    
</div>

<!--
<canvas id="plot"></canvas>
-->

</div>

<script src="https://unpkg.com/mathjs@8.1.0/lib/browser/math.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.min.js" integrity="sha512-SuxO9djzjML6b9w9/I07IWnLnQhgyYVSpHZx0JV97kGBfTIsUYlWflyuW4ypnvhBrslz1yJ3R+S14fdCWmSmSA==" crossorigin="anonymous"></script>
<script src="{{ '/assets/js/calculators.js' | relative_url }}"></script>