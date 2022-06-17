import "../css/pdf.css"

import { Previewer } from '../vendor/paged.js';

const previewer = new Previewer();
const html = document.querySelector('#root').innerHTML;
const $preview = document.querySelector('#preview');

previewer.preview(html, ['/assets/pdf.css'], $preview);

document.querySelector('.button-print').addEventListener('click', _e => window.print())
