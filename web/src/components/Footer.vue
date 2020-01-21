<template>
  <footer>
    <a href="mailto:hi@breadwinnerss.com">
      Get in touch
    </a>
    <a
      target="_blank"
      href="https://www.linkedin.com/pulse/simple-tool-turn-your-network-career-opportunities-nis-frome">
      About us
    </a>
    <span>
      Sandwiched by
      <a
        target="_blank"
        href="https://www.linkedin.com/in/nisfrome">
        Nis
      </a>,
      <a
        target="_blank"
        href="https://www.linkedin.com/in/elisabeth-gross-b2602433">
        Liz
      </a>,
      <a
        target="_blank"
        href="https://www.linkedin.com/in/hbertiger">
        Hannah
      </a>,
      <a
        target="_blank"
        href="https://www.linkedin.com/in/yairaviner">
        and Yair
      </a>
    </span>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>
  footer {
    display: flex;
    justify-content: center;
    padding: 10px 15px;
    width: 100%;
    box-shadow: -5px 0 40px 0 rgba(0,0,0,0.3);
  }
  footer > * {
    margin-right: 15px;
  }
  footer span {
    margin: 0;
    color: var(--color-secondary);
  }
  footer a {
    text-decoration: none;
  }

  @media (max-width: 500px) {
    footer {
      flex-direction: column;
    }
  }
</style>
