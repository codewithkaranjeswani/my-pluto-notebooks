### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 11e70fe0-d987-11eb-245c-db81de0329fb
url = "https://i.imgur.com/VGPeJ6s.jpg"  

# ╔═╡ 843a6c5c-f382-474b-addb-8941e6752770
begin
	using Images
	download(url, "philip.jpg")
end

# ╔═╡ 44f16bc6-0ad2-4dfe-80c0-db2ea763befc
philip = load("philip.jpg")

# ╔═╡ e167ad86-4a57-4d0f-acb9-94e050613803
typeof(philip)

# ╔═╡ b8db912c-3478-44d9-8931-40a8cafabde1
size(philip)

# ╔═╡ 95275236-b5ae-41ce-9592-21c8dee273fa
size(philip)[1]

# ╔═╡ 0ef602dc-2b73-4e04-9dc1-2ad2cfda81cd
begin
	(h,w) = size(philip)
	head = philip[h÷4:h÷2, w÷4:w÷2]
	head
end

# ╔═╡ fe7d0ded-f2d6-47c6-a4f4-8e4e55630f90
[head head]

# ╔═╡ 95ed376a-a5e2-4f29-8672-6a2dcf6a7cb1
[
	head reverse(head, dims=2)
	reverse(head, dims=1) reverse(reverse(head, dims=1), dims=2)
]

# ╔═╡ 1836c020-ae36-41b0-b3b2-dd62715b99da
begin
	# This is a comment, copy will create new memory for new variable
	new_phil = copy(head)
	new_phil
end

# ╔═╡ e4747f83-17cd-48ab-89f1-429038d6435b
begin
	new_phil2 = copy(new_phil)
	new_phil2[100:200, 100:200] .= RGBX(0.8, 0.5, 0.1)
	new_phil2
end

# ╔═╡ c0ec7536-5d06-4e0d-9616-a9cfb8fb0d5b
function redify(color)
	return RGB(color.r, 0, 0)
end

# ╔═╡ d15f4003-8e95-4a88-ae6c-d6dcaae14b09
redify.(new_phil)

# ╔═╡ 90d93c97-f629-4c5d-9caf-0169b93dd656


# ╔═╡ 9682f121-e078-4438-9956-ef1b2b116fba
decimate(image, ratio=5) = image[1:ratio:end, 1:ratio:end]

# ╔═╡ 971d69b4-3c92-41a9-966e-18c75af352de
begin
	poor_phil = decimate(philip, 10)
	poor_phil
end

# ╔═╡ Cell order:
# ╠═11e70fe0-d987-11eb-245c-db81de0329fb
# ╠═843a6c5c-f382-474b-addb-8941e6752770
# ╠═44f16bc6-0ad2-4dfe-80c0-db2ea763befc
# ╠═e167ad86-4a57-4d0f-acb9-94e050613803
# ╠═b8db912c-3478-44d9-8931-40a8cafabde1
# ╠═95275236-b5ae-41ce-9592-21c8dee273fa
# ╠═0ef602dc-2b73-4e04-9dc1-2ad2cfda81cd
# ╠═fe7d0ded-f2d6-47c6-a4f4-8e4e55630f90
# ╠═95ed376a-a5e2-4f29-8672-6a2dcf6a7cb1
# ╠═1836c020-ae36-41b0-b3b2-dd62715b99da
# ╠═e4747f83-17cd-48ab-89f1-429038d6435b
# ╠═c0ec7536-5d06-4e0d-9616-a9cfb8fb0d5b
# ╠═d15f4003-8e95-4a88-ae6c-d6dcaae14b09
# ╠═971d69b4-3c92-41a9-966e-18c75af352de
# ╠═90d93c97-f629-4c5d-9caf-0169b93dd656
# ╠═9682f121-e078-4438-9956-ef1b2b116fba
