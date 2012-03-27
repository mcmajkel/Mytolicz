var box = $('#dni'),
    wynik = $('#wynik');
(function () {
    wynik.hide();
    box.keyup(function () {
        var piniondz = $.get('oblicz/@dni');
        console.log(piniondz.responseText)
        if (piniondz > 0)
            wynik.html("<h1 align='right'>" + Math.round(piniondz) + " zĹ</h1>").slideDown();
    })
})();