import { Global, css } from '@emotion/react';

const GlobalStyle = () => {
  return <Global styles={globalCSS} />;
};

const resetCSS = css`
  html,
  body,
  div,
  span,
  applet,
  object,
  iframe,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  p,
  blockquote,
  pre,
  a,
  abbr,
  acronym,
  address,
  big,
  cite,
  code,
  del,
  dfn,
  em,
  img,
  ins,
  kbd,
  q,
  s,
  samp,
  small,
  strike,
  strong,
  sub,
  sup,
  tt,
  var,
  b,
  u,
  i,
  center,
  dl,
  dt,
  dd,
  ol,
  ul,
  li,
  fieldset,
  form,
  label,
  legend,
  table,
  caption,
  tbody,
  tfoot,
  thead,
  tr,
  th,
  td,
  article,
  aside,
  canvas,
  details,
  embed,
  figure,
  figcaption,
  footer,
  header,
  hgroup,
  menu,
  nav,
  output,
  ruby,
  section,
  summary,
  time,
  mark,
  audio,
  video {
    margin: 0;
    padding: 0;
    border: 0;
    font-size: 100%;
    vertical-align: baseline;
  }

  /* HTML5 display-role reset for older browsers */
  article,
  aside,
  details,
  figcaption,
  figure,
  footer,
  header,
  hgroup,
  menu,
  nav,
  section {
    display: block;
  }

  body {
    line-height: 1;
  }

  ol,
  ul {
    list-style: none;
  }

  blockquote,
  q {
    quotes: none;
  }

  blockquote:before,
  blockquote:after,
  q:before,
  q:after {
    content: '';
    content: none;
  }

  table {
    border-collapse: collapse;
    border-spacing: 0;
  }

  html,
  body {
    margin: 0;
    padding: 0;
  }

  * {
    box-sizing: border-box;
  }
`;

const globalCSS = css`
  @font-face {
    font-family: 'Hyundai Sans Head';
    font-style: normal;
    font-weight: 700;
    font-display: swap;
    src:
      local('Hyundai Sans Head Bold'),
      src('/fonts/HyundaiSansHead-Bold.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Head';
    font-style: normal;
    font-weight: 500;
    font-display: swap;
    src:
      local('Hyundai Sans Head Medium'),
      src('/fonts/HyundaiSansHead-Medium.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Head KR';
    font-style: normal;
    font-weight: 700;
    font-display: swap;
    src:
      local('Hyundai Sans Head KR Bold'),
      src('/fonts/HyundaiSansHeadKRBold.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Head KR';
    font-style: normal;
    font-weight: 500;
    font-display: swap;
    src:
      local('Hyundai Sans Head KR Medium'),
      src('/fonts/HyundaiSansHeadKRMedium.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Head KR';
    font-style: normal;
    font-weight: 400;
    font-display: swap;
    src:
      local('Hyundai Sans Head KR Regular'),
      src('/fonts/HyundaiSansHeadKRRegular.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Text';
    font-style: normal;
    font-weight: 500;
    font-display: swap;
    src:
      local('Hyundai Sans Text Medium'),
      src('/fonts/HyundaiSansText-Medium.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Text KR';
    font-style: normal;
    font-weight: 700;
    font-display: swap;
    src:
      local('Hyundai Sans Text KR Bold'),
      src('/fonts/HyundaiSansTextKRBold.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Text KR';
    font-style: normal;
    font-weight: 500;
    font-display: swap;
    src:
      local('Hyundai Sans Text KR Medium'),
      src('/fonts/HyundaiSansTextKRMedium.woff2') format('woff2');
  }

  @font-face {
    font-family: 'Hyundai Sans Text KR';
    font-style: normal;
    font-weight: 400;
    font-display: swap;
    src:
      local('Hyundai Sans Text KR Regular'),
      src('/fonts/HyundaiSansTextKRRegular.woff2') format('woff2');
  }

  ${resetCSS}
`;

export default GlobalStyle;
