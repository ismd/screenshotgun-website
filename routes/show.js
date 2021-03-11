var express = require('express');
var router = express.Router();

/* GET show page. */
router.get('/:year-:month-:day/:hash', function(req, res, next) {
    const date = `${req.params.year}/${req.params.month}/${req.params.day}`;
    const options = { year: 'numeric', month: 'long', day: 'numeric' };

    res.render('show', {
        date: new Date(req.params.year, req.params.month - 1, req.params.day).toLocaleDateString('ru-RU', options),
        src: `https://storage.yandexcloud.net/screenshots/${date}/${req.params.hash}.png`,
    });
});

module.exports = router;
