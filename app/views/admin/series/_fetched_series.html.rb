<% if series_data.present? %>
  <h2>Series Encontradas</h2>
  <table>
    <thead>
      <tr>
        <th>Nome-PT</th>
        <th>Nome Original</th>
        <th>Pais</th>
        <th>Popularidade</th>
        <th>Média de Votação</th>        
      </tr>
    </thead>
    <tbody>
      <% series_data.each do |series| %>
        <tr>
          <td><%= series[:nome_pt] %></td>
          <td><%= series[:nome_origem] %></td>
          <td><%= series[:pais] %></td>
          <td><%= series[:popularidade] %></td>
          <td><%= series[:media_votacao] %></td>
        </tr>
      <% end %>
    </tbody>
  </table>
<% else %>
  <p>Nenhuma série disponível</p>
<% end %>