---
layout: post
title:  "Online calculators"
date:   2020-11-02 22:41:57 -0800
category: Part 1
author:
permalink: /online-calculators
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum




<div class="row mb-4">
    <div class="col-12">
        <h3>Calculation 1</h3>
        <p>Calculation description</p>
        <div>
            \begin{align*}
            f(x) &= x^2 + (\sqrt{m} * sin(x)) + (m * cos(x/2))
            \end{align*}
        </div>
    </div>
    <div class="col">
        <form id="frmSampleCalculation1">
            <div class="row">
                <div class="col-auto ">
                    <label class="col-form-label">Value for x:</label>
                </div>
                <div class="col-auto ">
                    <input name="X" class="form-control">
                </div>
                 <div class="col-auto mt-3">
                    <label class="col-form-label">Value for m:</label>
                </div>
                <div class="col-auto mt-3">
                    <input name="M" class="form-control">
                </div>
                <div class="col-12 mt-3">
                    <button type="submit" class="btn btn-primary">Calculate</button>
                </div>
            </div>
        </form>
    </div>
    <div class="col">
        <div class="row">
            <div class="col-auto">
                <label class="col-form-label">Result:</label>
            </div>
            <div class="col-auto">
                <input readonly disabled class="form-control" id="calcultionResult" />
            </div>
        </div>
    </div>
</div>

<canvas id="plot"></canvas>


<script src="https://unpkg.com/mathjs@8.1.0/lib/browser/math.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.bundle.min.js" integrity="sha512-SuxO9djzjML6b9w9/I07IWnLnQhgyYVSpHZx0JV97kGBfTIsUYlWflyuW4ypnvhBrslz1yJ3R+S14fdCWmSmSA==" crossorigin="anonymous"></script>
<script src="{{ '/assets/js/calculators.js' | relative_url }}"></script>